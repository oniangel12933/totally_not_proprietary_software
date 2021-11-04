part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginPhoneChanged extends LoginEvent {
  const LoginPhoneChanged(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

// class LoginUsernameChanged extends LoginEvent {
//   const LoginUsernameChanged(this.username);
//
//   final String username;
//
//   @override
//   List<Object> get props => [username];
// }
//
// class LoginPasswordChanged extends LoginEvent {
//   const LoginPasswordChanged(this.password);
//
//   final String password;
//
//   @override
//   List<Object> get props => [password];
// }

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
