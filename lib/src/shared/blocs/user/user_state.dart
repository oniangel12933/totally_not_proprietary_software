import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insidersapp/gen/involio_api.swagger.dart';
import 'dart:convert';

part 'user_state.freezed.dart';

part 'user_state.g.dart';

UserState userStateFromJson(String str) => UserState.fromJson(json.decode(str));

String userStateToJson(UserState data) => json.encode(data.toJson());

@freezed
class UserState with _$UserState {
  const factory UserState({
    UserResponse? user,
  }) = _UserState;

  factory UserState.fromJson(Map<String, dynamic> json) =>
      _$UserStateFromJson(json);
}
