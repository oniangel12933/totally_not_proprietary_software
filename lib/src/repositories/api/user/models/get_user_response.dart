// To parse this JSON data, do
//
//     final getUserResponse = GetUserResponse_fromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'get_user_response.freezed.dart';
part 'get_user_response.g.dart';

GetUserResponse getUserResponseFromJson(String str) => GetUserResponse.fromJson(json.decode(str));

String getUserResponseToJson(GetUserResponse data) => json.encode(data.toJson());

@freezed
class GetUserResponse with _$GetUserResponse {
  const factory GetUserResponse({
    String? username,
    List<Post>? posts,
    List<Strategy>? strategies,
    List<Portfolio>? portfolios,
    List<Follower>? followers,
  }) = _GetUserResponse;

  factory GetUserResponse.fromJson(Map<String, dynamic> json) => _$GetUserResponseFromJson(json);
}

@freezed
class Follower with _$Follower {
  const factory Follower({
    int? id,
    String? username,
    DateTime? timestamp,
  }) = _Follower;

  factory Follower.fromJson(Map<String, dynamic> json) => _$FollowerFromJson(json);
}

@freezed
class Portfolio with _$Portfolio {
  const factory Portfolio({
    int? id,
    String? name,
    List<Review>? reviews,
    List<Asset>? assets,
    List<Update>? updates,
  }) = _Portfolio;

  factory Portfolio.fromJson(Map<String, dynamic> json) => _$PortfolioFromJson(json);
}

@freezed
class Asset with _$Asset {
  const factory Asset({
    int? id,
    String? symbol,
    String? price_target,
    String? notes,
  }) = _Asset;

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);
}

@freezed
class Review with _$Review {
  const factory Review({
    int? id,
    String? content,
    int? rating,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
}

@freezed
class Update with _$Update {
  const factory Update({
    int? id,
    String? content,
    DateTime? timestamp,
  }) = _Update;

  factory Update.fromJson(Map<String, dynamic> json) => _$UpdateFromJson(json);
}

@freezed
class Post with _$Post {
  const factory Post({
    int? id,
    String? content,
    int? likes,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

@freezed
class Strategy with _$Strategy {
  const factory Strategy({
    int? id,
    String? name,
    int? price,
    bool? free,
    String? description_text,
    List<Review>? reviews,
  }) = _Strategy;

  factory Strategy.fromJson(Map<String, dynamic> json) => _$StrategyFromJson(json);
}