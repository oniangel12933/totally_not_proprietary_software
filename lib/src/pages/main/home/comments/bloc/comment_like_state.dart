import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_like_state.freezed.dart';

part 'comment_like_state.g.dart';

CommentLikeState commentLikeStateFromJson(String str) =>
    CommentLikeState.fromJson(json.decode(str));

String commentLikeStateToJson(CommentLikeState data) =>
    json.encode(data.toJson());

@freezed
class CommentLikeState with _$CommentLikeState {
  const factory CommentLikeState({
    @Default(false) bool? isSavingLike,
    required String commentId,
    required int likeCnt,
    required bool isLiked,
    String? error,
  }) = CommentLikeStateMain;

  const factory CommentLikeState.initial({
    @Default(false) bool isSavingLike,
    String? error,
    required String commentId,
    required int likeCnt,
    required bool isLiked,
  }) = InitialCommentLikeState;

  const factory CommentLikeState.saving({
    @Default(true) bool isSavingLike,
    required String commentId,
    required int likeCnt,
    required bool isLiked,
    String? error,
  }) = SavingCommentLikeState;

  const factory CommentLikeState.success({
    @Default(true) bool isSavingLike,
    required String commentId,
    required int likeCnt,
    required bool isLiked,
    String? error,
  }) = SuccessCommentLikeState;

  const factory CommentLikeState.failure({
    @Default(true) bool isSavingLike,
    required String commentId,
    required int likeCnt,
    required bool isLiked,
    String? error,
  }) = FailureCommentLikeState;

  factory CommentLikeState.fromJson(Map<String, dynamic> json) =>
      _$CommentLikeStateFromJson(json);
}
