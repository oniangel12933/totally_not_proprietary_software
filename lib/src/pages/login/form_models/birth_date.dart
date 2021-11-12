import 'package:formz/formz.dart';

enum BirthDateValidationError { empty, toLong }

class BirthDate extends FormzInput<String, BirthDateValidationError> {
  const BirthDate.pure() : super.pure('');
  const BirthDate.dirty([String value = '']) : super.dirty(value);

  @override
  BirthDateValidationError? validator(String? value) {

    return value?.isNotEmpty == true ? null : BirthDateValidationError.empty;
  }
}
