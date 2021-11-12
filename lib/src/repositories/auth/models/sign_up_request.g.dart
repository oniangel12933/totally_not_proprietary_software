// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SignUpRequest _$$_SignUpRequestFromJson(Map<String, dynamic> json) =>
    _$_SignUpRequest(
      email: json['email'] as String?,
      username: json['username'] as String,
      phone: json['phone'] as String,
      name: json['name'] as String,
      birthdate: json['birthdate'] as String,
    );

Map<String, dynamic> _$$_SignUpRequestToJson(_$_SignUpRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'username': instance.username,
      'phone': instance.phone,
      'name': instance.name,
      'birthdate': instance.birthdate,
    };
