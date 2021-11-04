import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'otp_sms_login_request.freezed.dart';

part 'otp_sms_login_request.g.dart';

OtpSmsLoginRequest otpSmsLoginRequestFromJson(String str) =>
    OtpSmsLoginRequest.fromJson(json.decode(str));

String otpSmsLoginRequestToJson(OtpSmsLoginRequest data) =>
    json.encode(data.toJson());

@freezed
class OtpSmsLoginRequest with _$OtpSmsLoginRequest {
  const factory OtpSmsLoginRequest({
    required String phone,
    required String code,
  }) = _OtpSmsLoginRequest;

  factory OtpSmsLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$OtpSmsLoginRequestFromJson(json);
}
