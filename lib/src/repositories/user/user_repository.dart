import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:insidersapp/src/repositories/api_client/api_client.dart';
import 'package:insidersapp/src/repositories/auth/models/sign_up_request.dart';
import 'package:insidersapp/src/repositories/user/models/get_user_response.dart';
import 'models/models.dart';
import 'models/posts/post_like_remove_request.dart';
import 'models/posts/post_like_remove_response.dart';
import 'models/posts/post_like_request.dart';
import 'models/posts/post_like_response.dart';
import 'models/posts/posts_feed_request.dart';
import 'models/posts/posts_feed_response.dart';

class UserRepository {
  User? _user;

  // Future<User?> getUser() async {
  //   if (_user != null) return _user;
  //   return Future.delayed(
  //     const Duration(milliseconds: 300),
  //     () => _user = User(const Uuid().v4()),
  //   );
  // }

  Future<GetUserResponse> getUser() async {
    Response response = await Api().dio.get('api/user/get_user');

    return GetUserResponse.fromJson(response.data);
  }

  Future<PostsFeedResponse> getPostsFeed({
    required String filter,
    required int page,
    required int size,
  }) async {
    var request = PostsFeedRequest(
        context: Context(
          filter: filter,
        ),
        params: Params(
          page: page,
          size: size,
        ));

    //print("#############################");
    //print(request);

    Response response = await Api()
        .dio
        .post('api/social/feed/get_post_feed', data: jsonEncode(request.toJson()));

    return PostsFeedResponse.fromJson(response.data);
  }


  Future<PostLikeResponse> setPostLiked({
    required String postId,
  }) async {
    var request = PostLikeRequest(
        likedPostId: postId,
    );

    //print("#############################");
    //print(request);

    Response response = await Api()
        .dio
        .post('api/social/like/post', data: jsonEncode(request.toJson()));

    return PostLikeResponse.fromJson(response.data);
  }

  Future<PostLikeRemoveResponse> removePostLiked({
    required String postId,
  }) async {
    var request = PostLikeRemoveRequest(
      likedPostId: postId,
    );

    //print("#############################");
    //print(request);

    Response response = await Api()
        .dio
        .post('api/social/like/remove_post_like', data: jsonEncode(request.toJson()));

    return PostLikeRemoveResponse.fromJson(response.data);
  }
}