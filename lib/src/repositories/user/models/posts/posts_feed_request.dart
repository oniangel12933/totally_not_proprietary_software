import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'posts_feed_request.freezed.dart';
part 'posts_feed_request.g.dart';

PostsFeedRequest postsFeedRequestFromJson(String str) => PostsFeedRequest.fromJson(json.decode(str));

String postsFeedRequestToJson(PostsFeedRequest data) => json.encode(data.toJson());

@freezed
class PostsFeedRequest with _$PostsFeedRequest {
  const factory PostsFeedRequest({
    required Context context,
    required Params params,
  }) = _PostsFeedRequest;

  factory PostsFeedRequest.fromJson(Map<String, dynamic> json) => _$PostsFeedRequestFromJson(json);
}

@freezed
class Context with _$Context {
  const factory Context({
    required String filter,
  }) = _Context;

  factory Context.fromJson(Map<String, dynamic> json) => _$ContextFromJson(json);
}

@freezed
class Params with _$Params {
  const factory Params({
    required int page,
    required int size,
  }) = _Params;

  factory Params.fromJson(Map<String, dynamic> json) => _$ParamsFromJson(json);
}
