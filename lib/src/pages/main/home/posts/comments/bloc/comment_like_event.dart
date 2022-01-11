import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_like_event.freezed.dart';

part 'comment_like_event.g.dart';

CommentLikeEvent commentLikeEventFromJson(String str) =>
    CommentLikeEvent.fromJson(json.decode(str));

String commentLikeEventToJson(CommentLikeEvent data) =>
    json.encode(data.toJson());

@freezed
class CommentLikeEvent with _$CommentLikeEvent {
  const factory CommentLikeEvent.buttonPressed({
    String? commentId,
    bool? likeWas,
    int? likeCntWas,
  }) = CommentLikeButtonPressedEvent;

  factory CommentLikeEvent.fromJson(Map<String, dynamic> json) =>
      _$CommentLikeEventFromJson(json);
}
