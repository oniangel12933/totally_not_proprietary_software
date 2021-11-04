import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'otp_sms_start_request.freezed.dart';

part 'otp_sms_start_request.g.dart';

OtpSmsStartRequest otpSmsStartRequestFromJson(String str) =>
    OtpSmsStartRequest.fromJson(json.decode(str));

String otpSmsStartRequestToJson(OtpSmsStartRequest data) =>
    json.encode(data.toJson());

@freezed
class OtpSmsStartRequest with _$OtpSmsStartRequest {
  const factory OtpSmsStartRequest({
    required String phone,
  }) = _OtpSmsStartRequest;

  factory OtpSmsStartRequest.fromJson(Map<String, dynamic> json) =>
      _$OtpSmsStartRequestFromJson(json);
}
