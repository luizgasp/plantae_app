import 'package:app_module/app/modules/auth/submodules/register/domain/params/register_with_email_params.dart';
import 'package:app_module/app/modules/auth/submodules/register/domain/usecases/register_with_email_usecase.dart';
import 'package:app_module/app/modules/auth/submodules/register/presenter/blocs/register_bloc/register_bloc.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:core_module/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class RegisterWithEmailUsecaseMock extends Mock implements IRegisterWithEmailUsecase {}

class OverlayServiceMock extends Mock implements IOverlayService {}

void main() {
  late final IRegisterWithEmailUsecase registerWithEmailUsecase;
  late final IOverlayService overlayService;

  const kRegisterWithEmailParams = RegisterWithEmailParams(email: 'email', password: 'password');

  setUpAll(() {
    registerWithEmailUsecase = RegisterWithEmailUsecaseMock();
    overlayService = OverlayServiceMock();
  });

  setUp(() {
    registerFallbackValue(kRegisterWithEmailParams);
  });

  group('Register Bloc | ', () {
    blocTest<RegisterBloc, RegisterState>(
      'should emits RegisterSuccessfullState when register with email successfully',
      build: () {
        when(() => registerWithEmailUsecase.execute(any())).thenAnswer((_) async => right(unit));

        return RegisterBloc(registerWithEmailUsecase, overlayService);
      },
      act: (bloc) => bloc.add(RegisterWithEmailEvent(kRegisterWithEmailParams)),
      expect: () => [RegisterLoadingState(), RegisterSuccessfullState()],
    );

    blocTest<RegisterBloc, RegisterState>(
      'should emits RegisterErrorState when usecase fails',
      build: () {
        when(() => registerWithEmailUsecase.execute(any())).thenAnswer(
          (_) async => left(DomainError(message: '', stackTrace: StackTrace.empty)),
        );

        return RegisterBloc(registerWithEmailUsecase, overlayService);
      },
      act: (bloc) {
        const errorParams = RegisterWithEmailParams(email: '', password: '');

        return bloc.add(RegisterWithEmailEvent(errorParams));
      },
      expect: () => [RegisterLoadingState(), RegisterErrorState()],
    );
  });
}
