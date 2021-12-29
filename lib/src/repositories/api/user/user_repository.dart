import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:involio/gen/involio_api.swagger.dart';
import 'package:involio/src/repositories/api/api_client/api_client.dart';

class UserRepository {
  //User? _user;

  // Future<User?> getUser() async {
  //   if (_user != null) return _user;
  //   return Future.delayed(
  //     const Duration(milliseconds: 300),
  //     () => _user = User(const Uuid().v4()),
  //   );
  // }

  Future<UserResponse> getUser() async {
    Response response = await GetIt.I.get<Api>().dio.get('api/user/get_user');

    return UserResponse.fromJson(response.data);
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
    var request = CreateFollower(userId: userId,);

    Response response = await GetIt.I.get<Api>()
        .dio
        .post('api/social/follow/follow_user', data: jsonEncode(request.toJson()));

    return CreateFollowResponse.fromJson(response.data);
  }

  Future<CreateFollowResponse> unfollowUser({required String userId}) async {
    var request = RemoveFollow(userId: userId,);

    Response response = await GetIt.I.get<Api>()
        .dio
        .post('api/social/follow/unfollow_user', data: jsonEncode(request.toJson()));

    return CreateFollowResponse.fromJson(response.data);
  }
}
