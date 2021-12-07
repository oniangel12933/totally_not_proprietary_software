import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_event.freezed.dart';

part 'otp_event.g.dart';

OtpEvent otpEventFromJson(String str) => OtpEvent.fromJson(json.decode(str));

String otpEventToJson(OtpEvent data) => json.encode(data.toJson());

@freezed
class OtpEvent with _$OtpEvent {
  const factory OtpEvent.submitOtp({
    required String otp,
  }) = SubmitOtpEvent;

  const factory OtpEvent.retrievePhoneNumberFromStorage() =
      RetrievePhoneNumberFromStorageOtpEvent;

  const factory OtpEvent.resendSms() = ResendSmsOtpEvent;

  factory OtpEvent.fromJson(Map<String, dynamic> json) =>
      _$OtpEventFromJson(json);
}
