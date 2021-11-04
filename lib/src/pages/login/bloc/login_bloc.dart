import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:insidersapp/src/pages/login/form_models/phone_number.dart';
import 'package:insidersapp/src/repositories/auth/authentication_repository.dart';
import 'package:insidersapp/src/repositories/auth/models/otp_sms_start_response.dart';

import '../login.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginPhoneChanged>(_onPhoneChanged);
    // on<LoginUsernameChanged>(_onUsernameChanged);
    // on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onPhoneChanged(
    LoginPhoneChanged event,
    Emitter<LoginState> emit,
  ) {
    final phone = PhoneNumber.dirty(event.phone);
    emit(state.copyWith(
      phone: phone,
      status: Formz.validate([phone]),
    ));
  }

  // void _onUsernameChanged(
  //   LoginUsernameChanged event,
  //   Emitter<LoginState> emit,
  // ) {
  //   final username = Username.dirty(event.username);
  //   emit(state.copyWith(
  //     username: username,
  //     status: Formz.validate([state.password, username]),
  //   ));
  // }
  //
  // void _onPasswordChanged(
  //   LoginPasswordChanged event,
  //   Emitter<LoginState> emit,
  // ) {
  //   final password = Password.dirty(event.password);
  //   emit(state.copyWith(
  //     password: password,
  //     status: Formz.validate([password, state.username]),
  //   ));
  // }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        OtpSmsStartResponse response =
            await _authenticationRepository.getOtpForPhoneNumber(
          phone: state.phone.value,
          //password: state.password.value,
        );
        print('333333333333333333333333333333333333');
        print(response.error.runtimeType);

        if (response.error == null) {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        } else {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      } catch (e) {
        print('444444444');
        print(e);
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
