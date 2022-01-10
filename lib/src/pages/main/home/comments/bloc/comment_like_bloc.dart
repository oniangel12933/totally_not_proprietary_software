import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:involio/gen/involio_api.swagger.dart';
import 'package:involio/src/pages/main/home/comments/bloc/comment_like_event.dart';
import 'package:involio/src/pages/main/home/comments/bloc/comment_like_state.dart';
import 'package:involio/src/repositories/api/comments/comments_repository.dart';
import 'package:involio/src/shared/blocs/event_transformers/throttle.dart';

const throttleDuration = Duration(milliseconds: 200);

class CommentLikeBloc extends Bloc<CommentLikeEvent, CommentLikeState> {
  void likeButtonPressed({
    String? commentId,
    bool? likeWas,
    int? likeCntWas,
  }) {
    add(
      CommentLikeEvent.buttonPressed(
        commentId: commentId,
        likeWas: likeWas,
        likeCntWas: likeCntWas,
      ),
    );
  }

  CommentLikeBloc({
    required commentId,
    required likedCount,
    required liked,
  }) : super(CommentLikeState.initial(
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
    Emitter<CommentLikeState> emit,
  ) async {

    final String commentId = event.commentId ?? state.commentId;

    final bool likeWas = event.likeWas ?? state.isLiked;
    bool isLiked = !likeWas;

    final int likeCntWas = event.likeCntWas ?? state.likeCnt;
    int likeCnt = isLiked ? likeCntWas + 1 : likeCntWas - 1;

    emit(
      CommentLikeState.saving(
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
            CommentLikeState.success(
              commentId: commentId,
              isLiked: isLiked,
              likeCnt: likeCnt,
            ),
          );
        } else {
          emit(
            CommentLikeState.failure(
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
            CommentLikeState.success(
              commentId: commentId,
              isLiked: isLiked,
              likeCnt: likeCnt,
            ),
          );
        } else {
          emit(
            CommentLikeState.failure(
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
        CommentLikeState.failure(
          error: error.toString(),
          commentId: commentId,
          isLiked: likeWas,
          likeCnt: likeCntWas,
        ),
      );
    }
  }
}
