import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'posts_feed_response.freezed.dart';
part 'posts_feed_response.g.dart';

PostsFeedResponse postsFeedResponseFromJson(String str) => PostsFeedResponse.fromJson(json.decode(str));

String postsFeedResponseToJson(PostsFeedResponse data) => json.encode(data.toJson());

@freezed
class PostsFeedResponse with _$PostsFeedResponse {
  const factory PostsFeedResponse({
    List<Item>? items,
    int? total,
    int? page,
    int? size,
  }) = _PostsFeedResponse;

  factory PostsFeedResponse.fromJson(Map<String, dynamic> json) => _$PostsFeedResponseFromJson(json);
}

@freezed
class Item with _$Item {
  const factory Item({
    String? id,
    Owner? owner,
    OwnerAvatar? ownerAvatar,
    String? content,
    DateTime? timestamp,
    int? postLikes,
    int? postComments,
    int? tips,
    bool? liked,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}

@freezed
class Owner with _$Owner {
  const factory Owner({
    String? id,
    String? username,
    String? name,
  }) = _Owner;

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);
}

@freezed
class OwnerAvatar with _$OwnerAvatar {
  const factory OwnerAvatar({
    String? id,
    String? s3Object,
    String? fileType,
    DateTime? timestamp,
  }) = _OwnerAvatar;

  factory OwnerAvatar.fromJson(Map<String, dynamic> json) => _$OwnerAvatarFromJson(json);
}
