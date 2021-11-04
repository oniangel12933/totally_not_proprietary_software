import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'otp_sms_start_response.freezed.dart';

part 'otp_sms_start_response.g.dart';

OtpSmsStartResponse otpStartResponseFromJson(String str) =>
    OtpSmsStartResponse.fromJson(json.decode(str));

String otpStartResponseToJson(OtpSmsStartResponse data) =>
    json.encode(data.toJson());

@freezed
class OtpSmsStartResponse with _$OtpSmsStartResponse {
  const factory OtpSmsStartResponse({
    String? phoneNumber,
    bool? phoneVerified,
    String? requestLanguage,
    String? error,
  }) = _OtpSmsStartResponse;

  factory OtpSmsStartResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpSmsStartResponseFromJson(json);
}
