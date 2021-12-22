import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:involio/src/pages/login/form_models/phone_entity.dart';

part 'otp_state.freezed.dart';

part 'otp_state.g.dart';

OtpState otpStateFromJson(String str) => OtpState.fromJson(json.decode(str));

String otpStateToJson(OtpState data) => json.encode(data.toJson());

@freezed
class OtpState with _$OtpState {
  const factory OtpState({
    PhoneEntity? phone,
    String? accessToken,
    @Default(0) int expiresIn,
    @Default(false) bool submittingInProgress,
    @Default(false) bool resent,
    @Default(false) bool errorResending,
    @Default(false) bool errorSubmitting,
    @Default(false) bool errorMissingPhoneNumber,
  }) = _OtpState;

  factory OtpState.fromJson(Map<String, dynamic> json) =>
      _$OtpStateFromJson(json);
}
