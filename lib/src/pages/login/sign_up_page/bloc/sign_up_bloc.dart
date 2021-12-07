import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:get_it/get_it.dart';

import 'package:insidersapp/gen/involio_api.swagger.dart';
import 'package:insidersapp/src/pages/login/form_models/models.dart';
import 'package:insidersapp/src/pages/login/form_models/phone_entity.dart';
import 'package:insidersapp/src/repositories/api/auth/auth_repository.dart';
import 'package:insidersapp/src/repositories/local/secure_storage/secure_repository.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  static const secretName = 'Jory';

  //late final LoginFlowCubit _loginFlowCubit;

  SignUpBloc() : super(const SignUpState()) {
    on<SignUpNameChanged>(_onNameChanged);
    on<SignUpUsernameChanged>(_onUsernameChanged);
    on<SignUpPhoneChanged>(_onPhoneChanged);
    on<SignUpBirthDateChanged>(_onBirthDateChanged);
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  void _onNameChanged(
    SignUpNameChanged event,
    Emitter<SignUpState> emit,
  ) {
    if (event.name.trim().toLowerCase() == secretName.trim().toLowerCase()) {
      // this is for testing. needs to be removed eventually
      const Name name = Name.dirty(secretName);
      const Username username = Username.dirty('jory');
      const PhoneNumber phone = PhoneNumber.dirty(
          PhoneEntity(number: "4062093508", dialCode: '+1', isoCode: 'US'));
      const BirthDate birthDate = BirthDate.dirty("1978-03-22");

      emit(state.copyWith(
        name: name,
        username: username,
        phone: phone,
        birthDate: birthDate,
        signUpFormStatus: FormzStatus.valid,
      ));
    } else {
      final Name name = Name.dirty(event.name);

      emit(state.copyWith(
        name: name,
        signUpFormStatus: Formz.validate(
            [name, state.username, state.phone, state.birthDate]),
      ));
    }
  }

  void _onUsernameChanged(
    SignUpUsernameChanged event,
    Emitter<SignUpState> emit,
  ) {
    if (state.name.value == secretName) {
      return;
    }

    final username = Username.dirty(event.username);
    emit(state.copyWith(
      username: username,
      signUpFormStatus:
          Formz.validate([state.name, username, state.phone, state.birthDate]),
    ));
  }

  void phoneChanged({
    required PhoneEntity phone,
  }) {
    add(SignUpPhoneChanged(phone));
  }

  // void _onPhoneChanged(
  //     LoginPhoneChanged event,
  //     Emitter<LoginState> emit,
  //     ) {
  //   final phone = PhoneNumber2.dirty(event.phone);
  //   emit(state.copyWith(
  //     initialPhone: null,
  //     phone: phone,
  //     loginFormStatus: Formz.validate([phone]),
  //   ));
  // }

  void _onPhoneChanged(
    SignUpPhoneChanged event,
    Emitter<SignUpState> emit,
  ) {
    if (state.name.value == secretName) {
      return;
    }

    final phone = PhoneNumber.dirty(event.phone);
    emit(state.copyWith(
      phone: phone,
      signUpFormStatus:
          Formz.validate([state.name, state.username, phone, state.birthDate]),
    ));
  }

  void _onBirthDateChanged(
    SignUpBirthDateChanged event,
    Emitter<SignUpState> emit,
  ) {
    if (state.name.value == secretName) {
      return;
    }

    final birthDate = BirthDate.dirty(event.birthDate);
    emit(state.copyWith(
      birthDate: birthDate,
      signUpFormStatus:
          Formz.validate([state.name, state.username, state.phone, birthDate]),
    ));
  }

  void submitSignUp() {
    add(const SignUpSubmitted());
  }

  void _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    final AuthRepository _authRepository = GetIt.I.get<AuthRepository>();
    final SecureStorageRepository _secureRepository =
        GetIt.I.get<SecureStorageRepository>();

    if (state.signUpFormStatus.isValidated) {
      emit(state.copyWith(
          signUpFormStatus: FormzStatus.submissionInProgress, error: null));
      try {
        String fullPhoneNumber =
            '${state.phone.value.dialCode}${state.phone.value.number}';
        DateTime birthDate = DateTime.parse(state.birthDate.value);
        UserResponse signUpResponse = await _authRepository.signUpNewUser(
          email: null,
          username: state.username.value,
          phone: fullPhoneNumber,
          name: state.name.value,
          birthdate: birthDate,
        );

        //print('222222222222222222222222222222222222');
        //print(signUpResponse.error.runtimeType);

        if (signUpResponse.error == null) {
          //emit(state.copyWith(signUpFormStatus: FormzStatus.submissionSuccess));

          SMSStartResponse otpSmsStartResponse =
              await _authRepository.getOtpForPhoneNumber(
            phone: fullPhoneNumber,
          );

          //print('333333333333333333333333333333333333');
          //print(otpSmsStartResponse.error.runtimeType);

          if (otpSmsStartResponse.error == null) {
            print("persisting ${state.phone.value} to secure storage");
            await _secureRepository
                .persistPhoneNumber(state.phone.value.number);
            await _secureRepository
                .persistPhoneCountryCode(state.phone.value.dialCode);
            await _secureRepository
                .persistPhoneCountryISOCode(state.phone.value.isoCode);

            emit(state.copyWith(
                signUpFormStatus: FormzStatus.submissionSuccess, error: null));
          } else {
            emit(state.copyWith(
                signUpFormStatus: FormzStatus.submissionFailure,
                error: otpSmsStartResponse.error));
          }
        } else {
          emit(state.copyWith(
              signUpFormStatus: FormzStatus.submissionFailure,
              error: signUpResponse.error));
        }
      } catch (e) {
        print(e);
        emit(state.copyWith(
          signUpFormStatus: FormzStatus.submissionFailure,
          error: null,
        ));
      }
    }
  }
}
