part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.signUpFormStatus = FormzStatus.pure,
    this.name = const Name.pure(),
    this.username = const Username.pure(),
    this.phone = const PhoneNumber.pure(),
    //this.email = const Email.pure(),
    this.birthDate = const BirthDate.pure(),
    this.error,
  });

  final FormzStatus signUpFormStatus;
  final Name name;
  final Username username;
  final PhoneNumber phone;
  //final Email email;
  final BirthDate birthDate;
  final String? error;

  SignUpState copyWith({
    FormzStatus? signUpFormStatus,
    Name? name,
    Username? username,
    PhoneNumber? phone,
    //Email? email,
    BirthDate? birthDate,
    String? error,
  }) {
    return SignUpState(
      signUpFormStatus: signUpFormStatus ?? this.signUpFormStatus,
      name: name ?? this.name,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      //email: email ?? this.email,
      birthDate: birthDate ?? this.birthDate,
      error: error ?? this.error,
    );
  }

  @override
  //List<Object> get props => [signUpFormStatus, name, username, phone, email, birthDate];
  List<Object> get props => [signUpFormStatus, name, username, phone, birthDate];
}
