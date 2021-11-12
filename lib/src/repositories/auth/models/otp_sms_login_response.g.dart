// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_sms_login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OtpSmsLoginResponse _$$_OtpSmsLoginResponseFromJson(
        Map<String, dynamic> json) =>
    _$_OtpSmsLoginResponse(
      access_token: json['access_token'] as String?,
      id_token: json['id_token'] as String?,
      scope: json['scope'] as String?,
      expires_in: json['expires_in'] as int?,
      token_type: json['token_type'] as String?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$_OtpSmsLoginResponseToJson(
        _$_OtpSmsLoginResponse instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
      'id_token': instance.id_token,
      'scope': instance.scope,
      'expires_in': instance.expires_in,
      'token_type': instance.token_type,
      'error': instance.error,
    };
