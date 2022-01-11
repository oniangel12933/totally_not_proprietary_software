import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:involio/gen/involio_api.swagger.dart';
import 'package:involio/src/repositories/api/comments/comments_repository.dart';
import 'package:involio/src/shared/blocs/event_transformers/throttle.dart';

import 'post_comment_like_event.dart';
import 'post_comment_like_state.dart';

const throttleDuration = Duration(milliseconds: 200);

class PostCommentLikeBloc extends Bloc<PostCommentLikeEvent, PostCommentLikeState> {
  void likeButtonPressed({
    String? commentId,
    bool? likeWas,
    int? likeCntWas,
  }) {
    add(
      PostCommentLikeEvent.buttonPressed(
        commentId: commentId,
        likeWas: likeWas,
        likeCntWas: likeCntWas,
      ),
    );
  }

  PostCommentLikeBloc({
    required commentId,
    required likedCount,
    required liked,
  }) : super(PostCommentLikeState.initial(
          commentId: commentId,
          likeCnt: likedCount,
          isLiked: liked,
        )) {
    on<CommentLikeButtonPressedEvent>(
      _onLikeButtonPressed,
      transformer: throttle(throttleDuration),
    );
  }

  void _onLikeButtonPressed(
    CommentLikeButtonPressedEvent event,
    Emitter<PostCommentLikeState> emit,
  ) async {

    final String commentId = event.commentId ?? state.commentId;

    final bool likeWas = event.likeWas ?? state.isLiked;
    bool isLiked = !likeWas;

    final int likeCntWas = event.likeCntWas ?? state.likeCnt;
    int likeCnt = isLiked ? likeCntWas + 1 : likeCntWas - 1;

    emit(
      PostCommentLikeState.saving(
        commentId: commentId,
        isLiked: isLiked,
        likeCnt: likeCnt,
      ),
    );

    try {
      CommentsRepository commentsRepository = GetIt.I.get<CommentsRepository>();

      if (isLiked) {
        final LikeResponse commentLikeResponse =
            await commentsRepository.setCommentLiked(
          commentId: commentId,
        );

        if (commentLikeResponse.error == null) {
          emit(
            PostCommentLikeState.success(
              commentId: commentId,
              isLiked: isLiked,
              likeCnt: likeCnt,
            ),
          );
        } else {
          emit(
            PostCommentLikeState.failure(
              error: commentLikeResponse.error,
              commentId: commentId,
              isLiked: likeWas,
              likeCnt: likeCntWas,
            ),
          );
        }
      } else {
        final RemoveLikeResponse removeLikeResponse =
            await commentsRepository.removeCommentLiked(
          commentId: commentId,
        );

        if (removeLikeResponse.error == null) {
          emit(
            PostCommentLikeState.success(
              commentId: commentId,
              isLiked: isLiked,
              likeCnt: likeCnt,
            ),
          );
        } else {
          emit(
            PostCommentLikeState.failure(
              error: removeLikeResponse.error,
              commentId: commentId,
              isLiked: likeWas,
              likeCnt: likeCntWas,
            ),
          );
        }
      }
    } catch (error, trace) {
      print('catch CommentLikeBloc error: $error - $trace');

      emit(
        PostCommentLikeState.failure(
          error: error.toString(),
          commentId: commentId,
          isLiked: likeWas,
          likeCnt: likeCntWas,
        ),
      );
    }
  }
}
