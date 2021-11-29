import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'post_like_request.freezed.dart';
part 'post_like_request.g.dart';

PostLikeRequest postLikeRequestFromJson(String str) => PostLikeRequest.fromJson(json.decode(str));

String postLikeRequestToJson(PostLikeRequest data) => json.encode(data.toJson());

@freezed
class PostLikeRequest with _$PostLikeRequest {
  const factory PostLikeRequest({
    required String likedPostId,
  }) = _PostLikeRequest;

  factory PostLikeRequest.fromJson(Map<String, dynamic> json) => _$PostLikeRequestFromJson(json);
}
