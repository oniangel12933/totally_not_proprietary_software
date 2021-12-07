import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';
part 'auth_state.g.dart';

AuthState authStateFromJson(String str) => AuthState.fromJson(json.decode(str));

String authStateToJson(AuthState data) => json.encode(data.toJson());

@freezed
class AuthState with _$AuthState {
  //const factory AuthState() = _AuthState;
  const factory AuthState.authUninitialized() = AuthUninitialized;
  const factory AuthState.authAuthenticated() = AuthAuthenticated;
  const factory AuthState.authUnauthenticated() = AuthUnauthenticated;
  const factory AuthState.authLoading() = AuthLoading;
  const factory AuthState.authLoggingOut() = AuthLoggingOut;
  const factory AuthState.authLoggedOut() = AuthLoggedOut;

  factory AuthState.fromJson(Map<String, dynamic> json) => _$AuthStateFromJson(json);
}
