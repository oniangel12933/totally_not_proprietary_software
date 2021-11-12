part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginPhoneChanged extends LoginEvent {
  const LoginPhoneChanged({
    required this.phone,
  });

  final PhoneEntity phone;

  @override
  List<Object> get props => [phone];
}

class LoginLoadStoredNumber extends LoginEvent {
  const LoginLoadStoredNumber();

  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
