part of 'sign_up_bloc.dart';


abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpPhoneChanged extends SignUpEvent {
  const SignUpPhoneChanged(this.phone);

  final PhoneEntity phone;

  @override
  List<Object> get props => [phone];
}

class SignUpEmailChanged extends SignUpEvent {
  const SignUpEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class SignUpNameChanged extends SignUpEvent {
  const SignUpNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class SignUpUsernameChanged extends SignUpEvent {
  const SignUpUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class SignUpBirthDateChanged extends SignUpEvent {
  const SignUpBirthDateChanged(this.birthDate);

  final String birthDate;

  @override
  List<Object> get props => [birthDate];
}

class SignUpSubmitted extends SignUpEvent {
  const SignUpSubmitted();
}
