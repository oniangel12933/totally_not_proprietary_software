import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:involio/gen/involio_api.swagger.dart';
import 'package:involio/src/repositories/api/api_client/api_client.dart';

class CommentsRepository {
  final getIt = GetIt.instance;

  Future<CommentResponse> createPostComment({
    required String content,
    required String postId,
  }) async {
    var request = CreatePostComment(
      content: content,
      postId: postId,
    );

    Response response = await getIt.get<Api>().dio.post(
        'api/social/comment/create_post_comment',
        data: jsonEncode(request.toJson()));

    return CommentResponse.fromJson(response.data);
  }

  Future<GetUpdateCommentsResponse> getUpdateComments({
    required String content,
    required String updateId,
  }) async {
    var request = GetUpdateComments(
      updateId: updateId,
    );

    Response response = await getIt.get<Api>().dio.post(
        'api/social/comment/get_post_comments',
        data: jsonEncode(request.toJson()));

    return GetUpdateCommentsResponse.fromJson(response.data);
  }

  Future<GetPostCommentsResponse> getPostComments({
    required String postId,
    required int page,
    required int size,
    required String sorting,
  }) async {
    var request = GetPostComments(
      context: AppSharedSchemasPageSchemaPost(
        postId: postId,
      ),
      params: AppSharedSchemasPageSchemaParams(
        page: page,
        size: size,
      ),
      sorting: sorting,
    );

    Response response = await getIt.get<Api>().dio.post(
        'api/social/comment/get_post_comments',
        data: jsonEncode(request.toJson()));

    return GetPostCommentsResponse.fromJson(response.data);
  }

  Future<LikeResponse> setCommentLiked({
    required String commentId,
  }) async {
    var request = LikeComment(
      likedCommentId: commentId,
    );

    Response response = await getIt
        .get<Api>()
        .dio
        .post('api/social/like/comment', data: jsonEncode(request.toJson()));

    return LikeResponse.fromJson(response.data);
  }

  Future<RemoveLikeResponse> removeCommentLiked({
    required String commentId,
  }) async {
    var request = RemovePostLike(
      //TODO Change to LikeComment
      likedPostId: commentId,
    );

    Response response = await getIt.get<Api>().dio.post(
        'api/social/like/remove_comment_like',
        data: jsonEncode(request.toJson()));

    return RemoveLikeResponse.fromJson(response.data);
  }
}
