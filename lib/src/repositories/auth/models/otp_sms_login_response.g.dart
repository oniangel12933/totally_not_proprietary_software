// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_sms_login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OtpSmsLoginResponse _$$_OtpSmsLoginResponseFromJson(
        Map<String, dynamic> json) =>
    _$_OtpSmsLoginResponse(
      accessToken: json['accessToken'] as String?,
      idToken: json['idToken'] as String?,
      scope: json['scope'] as String?,
      expiresIn: json['expiresIn'] as int?,
      tokenType: json['tokenType'] as String?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$_OtpSmsLoginResponseToJson(
        _$_OtpSmsLoginResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'idToken': instance.idToken,
      'scope': instance.scope,
      'expiresIn': instance.expiresIn,
      'tokenType': instance.tokenType,
      'error': instance.error,
    };
