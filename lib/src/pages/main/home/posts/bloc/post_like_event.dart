import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_like_event.freezed.dart';
part 'post_like_event.g.dart';

PostLikeEvent postLikeEventFromJson(String str) => PostLikeEvent.fromJson(json.decode(str));

String postLikeEventToJson(PostLikeEvent data) => json.encode(data.toJson());

@freezed
class PostLikeEvent with _$PostLikeEvent {
  const factory PostLikeEvent.buttonPressed({
    String? postId,
    bool? likeWas,
    int? likeCntWas,
  }) = PostLikeButtonPressedEvent;

  factory PostLikeEvent.fromJson(Map<String, dynamic> json) => _$PostLikeEventFromJson(json);
}
