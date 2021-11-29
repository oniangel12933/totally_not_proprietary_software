import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'post_like_response.freezed.dart';
part 'post_like_response.g.dart';

PostLikeResponse postLikeResponseFromJson(String str) => PostLikeResponse.fromJson(json.decode(str));

String postLikeResponseToJson(PostLikeResponse data) => json.encode(data.toJson());

@freezed
class PostLikeResponse with _$PostLikeResponse {
  const factory PostLikeResponse({
    String? success,
    String? error,
  }) = _PostLikeResponse;

  factory PostLikeResponse.fromJson(Map<String, dynamic> json) => _$PostLikeResponseFromJson(json);
}
