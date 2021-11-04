// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_sms_start_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OtpSmsStartResponse _$$_OtpSmsStartResponseFromJson(
        Map<String, dynamic> json) =>
    _$_OtpSmsStartResponse(
      phoneNumber: json['phoneNumber'] as String?,
      phoneVerified: json['phoneVerified'] as bool?,
      requestLanguage: json['requestLanguage'] as String?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$_OtpSmsStartResponseToJson(
        _$_OtpSmsStartResponse instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'phoneVerified': instance.phoneVerified,
      'requestLanguage': instance.requestLanguage,
      'error': instance.error,
    };
