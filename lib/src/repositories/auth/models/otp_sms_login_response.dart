import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'otp_sms_login_response.freezed.dart';

part 'otp_sms_login_response.g.dart';

OtpSmsLoginResponse otpSmsLoginResponseFromJson(String str) =>
    OtpSmsLoginResponse.fromJson(json.decode(str));

String otpSmsLoginResponseToJson(OtpSmsLoginResponse data) =>
    json.encode(data.toJson());

@freezed
class OtpSmsLoginResponse with _$OtpSmsLoginResponse {
  const factory OtpSmsLoginResponse({
    String? accessToken,
    String? idToken,
    String? scope,
    int? expiresIn,
    String? tokenType,
    String? error,
  }) = _OtpSmsLoginResponse;

  factory OtpSmsLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpSmsLoginResponseFromJson(json);
}
