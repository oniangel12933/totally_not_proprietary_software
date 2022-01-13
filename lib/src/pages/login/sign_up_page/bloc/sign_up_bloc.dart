import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import 'package:involio/gen/involio_api.swagger.dart';
import 'package:involio/src/pages/login/form_models/models.dart';
import 'package:involio/src/pages/login/form_models/phone_entity.dart';
import 'package:involio/src/repositories/api/auth/auth_repository.dart';
import 'package:involio/src/repositories/local/secure_storage/secure_repository.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  static const secretName = 'Jory';

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

        DateFormat format = DateFormat("yyyy-M-d");
        DateTime birthDate = format.parse(state.birthDate.value);

        UserResponse signUpResponse = await _authRepository.signUpNewUser(
          email: null,
          username: state.username.value,
          phone: fullPhoneNumber,
          name: state.name.value,
          birthdate: birthDate,
        );

        if (signUpResponse.error == null) {
          SMSStartResponse otpSmsStartResponse =
              await _authRepository.getOtpForPhoneNumber(
            phone: fullPhoneNumber,
          );

          if (otpSmsStartResponse.error == null) {
            print("persisting ${state.phone.value} to secure storage");
            await _secureRepository
                .persistPhoneNumber(state.phone.value.number);
            await _secureRepository
                .persistPhoneCountryCode(state.phone.value.dialCode);
            await _secureRepository
                .persistPhoneCountryISOCode(state.phone.value.isoCode);

            emit(state.copyWith(
              signUpFormStatus: FormzStatus.submissionSuccess,
              error: null,
              goToWelcomePage: false,
            ));
          } else {
            /// go to welcome page because sign up was successful, but
            /// the otp start was not successful
            emit(state.copyWith(
                signUpFormStatus: FormzStatus.submissionSuccess,
                error: otpSmsStartResponse.error,
                goToWelcomePage: true));
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
