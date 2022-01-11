import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_comment_like_event.freezed.dart';

part 'post_comment_like_event.g.dart';

PostCommentLikeEvent commentLikeEventFromJson(String str) =>
    PostCommentLikeEvent.fromJson(json.decode(str));

String commentLikeEventToJson(PostCommentLikeEvent data) =>
    json.encode(data.toJson());

@freezed
class PostCommentLikeEvent with _$PostCommentLikeEvent {
  const factory PostCommentLikeEvent.buttonPressed({
    String? commentId,
    bool? likeWas,
    int? likeCntWas,
  }) = CommentLikeButtonPressedEvent;

  factory PostCommentLikeEvent.fromJson(Map<String, dynamic> json) =>
      _$PostCommentLikeEventFromJson(json);
}
