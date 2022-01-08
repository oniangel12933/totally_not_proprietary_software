import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:involio/gen/involio_api.swagger.dart';
import 'package:involio/src/repositories/api/api_client/api_client.dart';
import 'package:involio/src/shared/cache/cache.dart';

UserBaseResponse userResponseFromJson(String str) =>
    UserBaseResponse.fromJson(json.decode(str));

String userResponseToJson(UserBaseResponse data) => json.encode(data.toJson());

class UserRepository {
  static String userCacheKey = "user_me";

  Future<void> clearUserCache() async {
    GetIt.I.get<SimpleCache>().clear();
  }

  Future<UserBaseResponse> getUser() async {
    SimpleCache simpleCache = GetIt.I.get<SimpleCache>();

    String? cachedUserJson = await simpleCache.getString(
      userCacheKey,
    );

    if (cachedUserJson != null) {
      try {
        UserBaseResponse userResponse = userResponseFromJson(cachedUserJson);
        print("return cached user");
        return userResponse;
      } on Exception {}
    }

    Response response = await GetIt.I.get<Api>().dio.get('api/user/get_user');
    UserBaseResponse userResponse = UserBaseResponse.fromJson(response.data);

    await simpleCache.setString(
      key: userCacheKey,
      value: userResponseToJson(userResponse),
    );

    return userResponse;
  }

  Future<TrendingUserResponse> getTrendingUsers({
    required int page,
    required int size,
  }) async {
    var request = GetTrendingUsers(
        context: AppSharedSchemasPageSchemaFilter(
          filter: "users",
        ),
        params: AppSharedSchemasPageSchemaParams(
          page: page,
          size: size,
        ));

    Response response = await GetIt.I.get<Api>().dio.post(
        'api/social/trending/get_users',
        data: jsonEncode(request.toJson()));

    return TrendingUserResponse.fromJson(response.data);
  }

  Future<CreateFollowResponse> followUser({required String userId}) async {
    var request = CreateFollower(userId: userId);

    Response response = await GetIt.I.get<Api>().dio.post(
        'api/social/follow/follow_user',
        data: jsonEncode(request.toJson()));

    return CreateFollowResponse.fromJson(response.data);
  }

  Future<CreateFollowResponse> unfollowUser({required String userId}) async {
    var request = RemoveFollow(userId: userId);

    Response response = await GetIt.I.get<Api>().dio.post(
        'api/social/follow/unfollow_user',
        data: jsonEncode(request.toJson()));

    return CreateFollowResponse.fromJson(response.data);
  }
}
