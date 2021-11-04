part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.phone = const PhoneNumber.pure(),
    // this.username = const Username.pure(),
    // this.password = const Password.pure(),
  });

  final FormzStatus status;
  final PhoneNumber phone;
  // final Username username;
  // final Password password;

  LoginState copyWith({
    FormzStatus? status,
    PhoneNumber? phone,
    // Username? username,
    // Password? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      phone: phone ?? this.phone,
      // username: username ?? this.username,
      // password: password ?? this.password,
    );
  }

  @override
  //List<Object> get props => [status, username, password];
  List<Object> get props => [status, phone];
}
