import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'sign_up_response.freezed.dart';
part 'sign_up_response.g.dart';

SignUpResponse signUpResponseFromJson(String str) => SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

@freezed
class SignUpResponse with _$SignUpResponse {
  const factory SignUpResponse({
    String? error,
    String? response,
    bool? success,
    String? access_token,
  }) = _SignUpResponse;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => _$SignUpResponseFromJson(json);
}
