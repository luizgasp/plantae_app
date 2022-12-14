import 'package:app_module/app/modules/auth/submodules/login/domain/params/login_with_email_params.dart';
import 'package:app_module/app/modules/auth/submodules/register/domain/params/register_with_email_params.dart';
import 'package:dependency_module/dependency_module.dart';

import '../../errors/auth_error.dart';
import 'i_auth_service.dart';

class FirebaseAuthServiceImpl implements IAuthService {
  final FirebaseAuth _firebaseAuth;

  const FirebaseAuthServiceImpl(this._firebaseAuth);

  @override
  Future<void> registerWithEmail(RegisterWithEmailParams params) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: params.email, password: params.password);
    } on FirebaseAuthException catch (error, stackTrace) {
      switch (error.code) {
        case 'invalid-email':
          throw AuthError(message: 'Invalid e-mail', stackTrace: stackTrace);
        case 'email-already-in-use':
          throw AuthError(message: 'E-mail already in use', stackTrace: stackTrace);
        case 'weak-password':
          throw AuthError(message: 'Weak password, please try again', stackTrace: stackTrace);
        default:
          throw AuthError(message: 'Register error', stackTrace: stackTrace);
      }
    }
  }

  @override
  Future<void> loginWithEmail(LoginWithEmailParams params) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: params.email, password: params.password);
    } on FirebaseAuthException catch (error, stackTrace) {
      switch (error.code) {
        case 'invalid-email':
          throw AuthError(message: 'Invalid e-mail', stackTrace: stackTrace);
        case 'user-not-found':
          throw AuthError(message: 'User not found', stackTrace: stackTrace);
        case 'wrong-password':
          throw AuthError(message: 'Wrong password', stackTrace: stackTrace);
        default:
          throw AuthError(message: 'Login Error', stackTrace: stackTrace);
      }
    }
  }

  @override
  Future<void> logout() async => await _firebaseAuth.signOut();

  @override
  String get currentUserId => _firebaseAuth.currentUser!.uid;

  @override
  bool get isUserAuthenticated => _firebaseAuth.currentUser != null;
}
