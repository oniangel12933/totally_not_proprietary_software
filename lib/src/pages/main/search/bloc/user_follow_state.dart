import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_follow_state.freezed.dart';
part 'user_follow_state.g.dart';

UserFollowState userFollowStateFromJson(String str) => UserFollowState.fromJson(json.decode(str));

String userFollowStateToJson(UserFollowState data) => json.encode(data.toJson());

@freezed
class UserFollowState with _$UserFollowState {
  const factory UserFollowState({
    @Default(false) bool? isSavingFollow,
    required String userId,
    required bool isFollowing,
    required int followersCnt,
    String? error,
  }) = UserFollowStateMain;

  const factory UserFollowState.initial({
    @Default(false) bool? isSavingFollow,
    required String userId,
    required bool isFollowing,
    required int followersCnt,
    String? error,
  }) = InitialUserFollowState;

  const factory UserFollowState.saving({
    @Default(true) bool? isSavingFollow,
    required String userId,
    required bool isFollowing,
    required int followersCnt,
    String? error,
  }) = SavingUserFollowState;

  const factory UserFollowState.success({
    @Default(true) bool? isSavingFollow,
    required String userId,
    required bool isFollowing,
    required int followersCnt,
    String? error,
  }) = SuccessUserFollowState;

  const factory UserFollowState.failure({
    @Default(true) bool? isSavingFollow,
    required String userId,
    required bool isFollowing,
    required int followersCnt,
    String? error,
  }) = FailureUserFollowState;

  factory UserFollowState.fromJson(Map<String, dynamic> json) => _$UserFollowStateFromJson(json);
}