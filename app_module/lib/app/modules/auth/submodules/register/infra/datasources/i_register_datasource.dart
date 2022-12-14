import '../../domain/params/register_with_email_params.dart';

abstract class IRegisterDatasource {
  Future<void> registerWithEmail(RegisterWithEmailParams params);
}
