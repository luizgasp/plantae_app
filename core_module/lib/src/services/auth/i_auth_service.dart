import 'package:app_module/app/modules/auth/submodules/login/domain/params/login_with_email_params.dart';
import 'package:app_module/app/modules/auth/submodules/register/domain/params/register_with_email_params.dart';

abstract class IAuthService {
  Future<void> registerWithEmail(RegisterWithEmailParams params);
  Future<void> loginWithEmail(LoginWithEmailParams params);
  Future<void> logout();
  String get currentUserId;
  bool get isUserAuthenticated;
}
