import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plantae/app/core/errors/datasource_error.dart';
import 'package:plantae/app/core/helpers/either.dart';
import 'package:plantae/app/modules/auth/login/domain/params/login_with_email_params.dart';
import 'package:plantae/app/modules/auth/login/domain/repositories/i_login_repository.dart';
import 'package:plantae/app/modules/auth/login/infra/datasources/i_login_datasource.dart';
import 'package:plantae/app/modules/auth/login/infra/repositories/login_repository_impl.dart';

class LoginDatasourceMock extends Mock implements ILoginDatasource {}

void main() {
  late final ILoginDatasource loginDatasource;
  late final ILoginRepository sut;

  const kLoginWithEmailParams = LoginWithEmailParams(email: '', password: '');

  setUpAll(() {
    loginDatasource = LoginDatasourceMock();
    sut = LoginRepositoryImpl(loginDatasource);
  });

  setUp(() {
    registerFallbackValue(kLoginWithEmailParams);
  });

  group('Login Repository | ', () {
    group('With Email | ', () {
      test('should be able to call Datasource successfully and return an Unit', () async {
        when(() => loginDatasource.loginWithEmail(any())).thenAnswer((_) async {});

        final response = await sut.loginWithEmail(kLoginWithEmailParams);

        verify(() => loginDatasource.loginWithEmail(any())).called(1);
        expect(response.fold((l) => l, (r) => r), isA<Unit>());
      });

      test('should be able to return a DatasourceError if Datasource fails', () async {
        when(() => loginDatasource.loginWithEmail(any())).thenThrow(
          DatasourceError(message: '', stackTrace: StackTrace.empty),
        );

        final response = await sut.loginWithEmail(kLoginWithEmailParams);

        verify(() => loginDatasource.loginWithEmail(any())).called(1);
        expect(response.fold((l) => l, (r) => r), isA<DatasourceError>());
      });
    });
  });
}