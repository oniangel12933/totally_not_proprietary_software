import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_entity.freezed.dart';
part 'phone_entity.g.dart';

PhoneEntity phoneEntityFromJson(String str) =>
    PhoneEntity.fromJson(json.decode(str));

String phoneEntityToJson(PhoneEntity data) => json.encode(data.toJson());

@freezed
class PhoneEntity with _$PhoneEntity {
  const PhoneEntity._();

  const factory PhoneEntity({
    required String number,
    required String dialCode,
    required String isoCode,
  }) = _PhoneEntity;

  factory PhoneEntity.fromJson(Map<String, dynamic> json) =>
      _$PhoneEntityFromJson(json);

  static const empty = PhoneEntity(number: '', dialCode: '', isoCode: '');

  String completeNumber() {
    return '$dialCode$number';
  }
}
