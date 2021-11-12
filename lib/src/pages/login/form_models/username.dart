import 'package:formz/formz.dart';

enum UsernameValidationError { empty, toLong }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidationError? validator(String? value) {
    if (value?.isNotEmpty == true) {
      // if(value != null && value.length > 3){
      //   return UsernameValidationError.toLong;
      // }
    } else {
      return UsernameValidationError.empty;
    }
    return null;
  }
}
