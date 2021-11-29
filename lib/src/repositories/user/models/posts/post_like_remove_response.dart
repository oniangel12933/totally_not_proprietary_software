import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'post_like_remove_response.freezed.dart';
part 'post_like_remove_response.g.dart';

PostLikeRemoveResponse postLikeRemoveResponseFromJson(String str) => PostLikeRemoveResponse.fromJson(json.decode(str));

String postLikeRemoveResponseToJson(PostLikeRemoveResponse data) => json.encode(data.toJson());

@freezed
class PostLikeRemoveResponse with _$PostLikeRemoveResponse {
  const factory PostLikeRemoveResponse({
    bool? success,
    String? error,
  }) = _PostLikeRemoveResponse;

  factory PostLikeRemoveResponse.fromJson(Map<String, dynamic> json) => _$PostLikeRemoveResponseFromJson(json);
}
