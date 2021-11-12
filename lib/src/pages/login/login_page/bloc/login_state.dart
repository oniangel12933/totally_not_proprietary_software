part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.loginFormStatus = FormzStatus.pure,
    this.phone = const PhoneNumber.pure(),
    this.initialPhone,
    this.readyToDisplay = false,
  });

  final FormzStatus loginFormStatus;

  final PhoneNumber phone;

  final PhoneEntity? initialPhone;

  final bool readyToDisplay;

  LoginState copyWith({
    FormzStatus? loginFormStatus,
    PhoneNumber? phone,
    PhoneEntity? initialPhone,
    bool? readyToDisplay,
  }) {
    return LoginState(
      loginFormStatus: loginFormStatus ?? this.loginFormStatus,
      phone: phone ?? this.phone,
      initialPhone: initialPhone ?? this.initialPhone,
      readyToDisplay: readyToDisplay ?? this.readyToDisplay,
    );
  }

  @override
  List<Object?> get props => [
        loginFormStatus,
        phone,
        initialPhone,
        readyToDisplay,
      ];
}
