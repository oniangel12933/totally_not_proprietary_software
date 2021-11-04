//     final signUpRequest = signUpRequestFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'sign_up_request.freezed.dart';
part 'sign_up_request.g.dart';

SignUpRequest signUpRequestFromJson(String str) => SignUpRequest.fromJson(json.decode(str));

String signUpRequestToJson(SignUpRequest data) => json.encode(data.toJson());

@freezed
class SignUpRequest with _$SignUpRequest {
  const factory SignUpRequest({
    String? email,
    String? username,
    String? phone,
    String? firstName,
    String? lastName,
    DateTime? birthdate,
  }) = _SignUpRequest;

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => _$SignUpRequestFromJson(json);
}
