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
    this.goToWelcomePage,
  });

  final FormzStatus signUpFormStatus;
  final Name name;
  final Username username;
  final PhoneNumber phone;
  final BirthDate birthDate;
  final String? error;
  final bool? goToWelcomePage;

  SignUpState copyWith({
    FormzStatus? signUpFormStatus,
    Name? name,
    Username? username,
    PhoneNumber? phone,
    BirthDate? birthDate,
    String? error,
    bool? goToWelcomePage,
  }) {
    return SignUpState(
      signUpFormStatus: signUpFormStatus ?? this.signUpFormStatus,
      name: name ?? this.name,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
      error: error ?? this.error,
      goToWelcomePage: goToWelcomePage ?? this.goToWelcomePage,
    );
  }

  @override
  List<Object?> get props => [signUpFormStatus, name, username, phone, birthDate, error];
}
