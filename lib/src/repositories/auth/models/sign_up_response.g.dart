// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SignUpResponse _$$_SignUpResponseFromJson(Map<String, dynamic> json) =>
    _$_SignUpResponse(
      error: json['error'] as String?,
      response: json['response'] as String?,
      success: json['success'] as bool?,
      access_token: json['access_token'] as String?,
    );

Map<String, dynamic> _$$_SignUpResponseToJson(_$_SignUpResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'response': instance.response,
      'success': instance.success,
      'access_token': instance.access_token,
    };
