// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_sms_start_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OtpSmsStartResponse _$$_OtpSmsStartResponseFromJson(
        Map<String, dynamic> json) =>
    _$_OtpSmsStartResponse(
      phone_number: json['phone_number'] as String?,
      phone_verified: json['phone_verified'] as bool?,
      request_language: json['request_language'] as String?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$_OtpSmsStartResponseToJson(
        _$_OtpSmsStartResponse instance) =>
    <String, dynamic>{
      'phone_number': instance.phone_number,
      'phone_verified': instance.phone_verified,
      'request_language': instance.request_language,
      'error': instance.error,
    };
