import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_comment_like_state.freezed.dart';

part 'post_comment_like_state.g.dart';

PostCommentLikeState commentLikeStateFromJson(String str) =>
    PostCommentLikeState.fromJson(json.decode(str));

String commentLikeStateToJson(PostCommentLikeState data) =>
    json.encode(data.toJson());

@freezed
class PostCommentLikeState with _$PostCommentLikeState {
  const factory PostCommentLikeState({
    @Default(false) bool? isSavingLike,
    required String commentId,
    required int likeCnt,
    required bool isLiked,
    String? error,
  }) = CommentLikeStateMain;

  const factory PostCommentLikeState.initial({
    @Default(false) bool isSavingLike,
    String? error,
    required String commentId,
    required int likeCnt,
    required bool isLiked,
  }) = InitialCommentLikeState;

  const factory PostCommentLikeState.saving({
    @Default(true) bool isSavingLike,
    required String commentId,
    required int likeCnt,
    required bool isLiked,
    String? error,
  }) = SavingCommentLikeState;

  const factory PostCommentLikeState.success({
    @Default(true) bool isSavingLike,
    required String commentId,
    required int likeCnt,
    required bool isLiked,
    String? error,
  }) = SuccessCommentLikeState;

  const factory PostCommentLikeState.failure({
    @Default(true) bool isSavingLike,
    required String commentId,
    required int likeCnt,
    required bool isLiked,
    String? error,
  }) = FailureCommentLikeState;

  factory PostCommentLikeState.fromJson(Map<String, dynamic> json) =>
      _$PostCommentLikeStateFromJson(json);
}
