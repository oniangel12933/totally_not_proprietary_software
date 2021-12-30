import 'package:formz/formz.dart';

import 'package:involio/src/pages/login/form_models/phone_entity.dart';

enum PhoneNumberValidationError { empty, toLong }

class PhoneNumber extends FormzInput<PhoneEntity, PhoneNumberValidationError> {
  const PhoneNumber.pure() : super.pure(PhoneEntity.empty);
  const PhoneNumber.dirty([PhoneEntity value = PhoneEntity.empty]) : super.dirty(value);

  @override
  PhoneNumberValidationError? validator(PhoneEntity? value) {

    if (value?.number == null || value?.number.isEmpty == true) {
      return PhoneNumberValidationError.empty;
    }

    return null;
  }
}
