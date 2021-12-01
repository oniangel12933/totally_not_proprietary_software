import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'post_like_remove_request.freezed.dart';
part 'post_like_remove_request.g.dart';

PostLikeRemoveRequest postLikeRemoveRequestFromJson(String str) => PostLikeRemoveRequest.fromJson(json.decode(str));

String postLikeRemoveRequestToJson(PostLikeRemoveRequest data) => json.encode(data.toJson());

@freezed
class PostLikeRemoveRequest with _$PostLikeRemoveRequest {
  const factory PostLikeRemoveRequest({
    required String likedPostId,
  }) = _PostLikeRemoveRequest;

  factory PostLikeRemoveRequest.fromJson(Map<String, dynamic> json) => _$PostLikeRemoveRequestFromJson(json);
}
