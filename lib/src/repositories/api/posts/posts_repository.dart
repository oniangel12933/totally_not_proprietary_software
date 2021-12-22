import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:involio/gen/involio_api.swagger.dart';
import 'package:involio/src/repositories/api/api_client/api_client.dart';

class PostsRepository {
  final getIt = GetIt.instance;

  Future<PostFeedResponse> getPostsFeed({
    required String filter,
    required int page,
    required int size,
  }) async {

    // var request = BodyGetPostFeedApiSocialFeedGetPostFeedPost(
    //     context: GetFeed(
    //       filter: filter,
    //     ),
    //     params: Params(
    //       page: page,
    //       size: size,
    //     ));

    var request = GetFeed(
        context: AppApiFeedSchemaFilter(
          filter: filter,
        ),
        params: AppApiFeedSchemaParams(
          page: page,
          size: size,
        ));

    Response response = await getIt.get<Api>()
        .dio
        .post('api/social/feed/get_post_feed', data: jsonEncode(request.toJson()));

    PostFeedResponse postFeedResponse = PostFeedResponse.fromJson(response.data);
    return postFeedResponse;
  }

  Future<LikeResponse> setPostLiked({
    required String postId,
  }) async {
    var request = LikePost(
        likedPostId: postId,
    );

    Response response = await getIt.get<Api>()
        .dio
        .post('api/social/like/post', data: jsonEncode(request.toJson()));

    return LikeResponse.fromJson(response.data);
  }

  Future<RemoveLikeResponse> removePostLiked({
    required String postId,
  }) async {
    var request = RemovePostLike(
      likedPostId: postId,
    );

    Response response = await getIt.get<Api>()
        .dio
        .post('api/social/like/remove_post_like', data: jsonEncode(request.toJson()));

    return RemoveLikeResponse.fromJson(response.data);
  }
}
