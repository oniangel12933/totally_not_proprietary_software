import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_like_state.freezed.dart';
part 'post_like_state.g.dart';

PostLikeState postLikeStateFromJson(String str) => PostLikeState.fromJson(json.decode(str));

String postLikeStateToJson(PostLikeState data) => json.encode(data.toJson());

@freezed
class PostLikeState with _$PostLikeState {
  const factory PostLikeState({
    @Default(false) bool? isSavingLike,
    required String postId,
    required int likeCnt,
    required bool isLiked,
    String? error,
  }) = PostLikeStateMain;

  const factory PostLikeState.initial({
    @Default(false) bool isSavingLike,
    String? error,
    required String postId,
    required int likeCnt,
    required bool isLiked,
  }) = InitialPostLikeState;

  const factory PostLikeState.saving({
    @Default(true) bool isSavingLike,
    required String postId,
    required int likeCnt,
    required bool isLiked,
    String? error,
  }) = SavingPostLikeState;

  const factory PostLikeState.success({
    @Default(true) bool isSavingLike,
    required String postId,
    required int likeCnt,
    required bool isLiked,
    String? error,
  }) = SuccessPostLikeState;

  const factory PostLikeState.failure({
    @Default(true) bool isSavingLike,
    required String postId,
    required int likeCnt,
    required bool isLiked,
    String? error,
  }) = FailurePostLikeState;

  factory PostLikeState.fromJson(Map<String, dynamic> json) => _$PostLikeStateFromJson(json);
}
