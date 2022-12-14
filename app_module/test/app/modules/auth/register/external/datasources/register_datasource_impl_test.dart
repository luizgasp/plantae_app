import 'package:app_module/app/modules/auth/submodules/register/domain/params/register_with_email_params.dart';
import 'package:app_module/app/modules/auth/submodules/register/external/datasources/register_datasource_impl.dart';
import 'package:app_module/app/modules/auth/submodules/register/infra/datasources/i_register_datasource.dart';
import 'package:core_module/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _AuthServiceMock extends Mock implements IAuthService {}

void main() {
  late final IAuthService authService;
  late final IRegisterDatasource sut;

  const kRegisterWithEmailParams = RegisterWithEmailParams(email: '', password: '');

  setUpAll(() {
    authService = _AuthServiceMock();
    sut = RegisterDatasourceImpl(authService);
  });

  setUp(() {
    registerFallbackValue(kRegisterWithEmailParams);
  });

  group('Register Datasource | ', () {
    group('With Email | ', () {
      test('should be able to Login using AuthService', () async {
        when(() => authService.registerWithEmail(any())).thenAnswer((_) async {});

        await sut.registerWithEmail(kRegisterWithEmailParams);

        verify(() => authService.registerWithEmail(any())).called(1);
      });

      test('should throw a AuthError when AuthService fails', () async {
        when(() => authService.registerWithEmail(any())).thenThrow(
          AuthError(message: '', stackTrace: StackTrace.empty),
        );

        expect(() => sut.registerWithEmail(kRegisterWithEmailParams), throwsA(isA<AuthError>()));
      });
    });
  });
}
