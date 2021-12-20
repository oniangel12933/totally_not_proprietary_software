import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:insidersapp/gen/involio_api.swagger.dart';
import 'package:insidersapp/src/pages/main/home/posts/bloc/post_like_event.dart';
import 'package:insidersapp/src/pages/main/home/posts/bloc/post_like_state.dart';
import 'package:insidersapp/src/repositories/api/posts/posts_repository.dart';
import 'package:insidersapp/src/shared/blocs/event_transformers/throttle.dart';

const throttleDuration = Duration(milliseconds: 200);

class PostLikeBloc extends Bloc<PostLikeEvent, PostLikeState> {

  void likeButtonPressed({
    String? postId,
    bool? likeWas,
    int? likeCntWas,
  }) {
    add(
      PostLikeEvent.buttonPressed(
        postId: postId,
        likeWas: likeWas,
        likeCntWas: likeCntWas,
      ),
    );
  }

  PostLikeBloc({
    required postId,
    required likedCount,
    required liked,
  }) : super(PostLikeState.initial(
          postId: postId,
          likeCnt: likedCount,
          isLiked: liked,
        )) {
    on<PostLikeButtonPressedEvent>(
      _onLikeButtonPressed,
      transformer: throttle(throttleDuration),
    );
  }

  void _onLikeButtonPressed(
    PostLikeButtonPressedEvent event,
    Emitter<PostLikeState> emit,
  ) async {
    //print('--- like button pressed');

    final String postId = event.postId ?? state.postId;

    final bool likeWas = event.likeWas ?? state.isLiked;
    bool isLiked = false;

    final int likeCntWas = event.likeCntWas ?? state.likeCnt;
    int likeCnt = likeCntWas;

    if (likeWas == true) {
      likeCnt = likeCntWas - 1;
      isLiked = false;
    }

    if (likeWas == false) {
      likeCnt = likeCntWas + 1;
      isLiked = true;
    }

    emit(
      PostLikeState.saving(
        postId: postId,
        isLiked: isLiked,
        likeCnt: likeCnt,
      ),
    );

    try {
      PostsRepository postsRepository = GetIt.I.get<PostsRepository>();

      if (isLiked) {
        final LikeResponse postLikeResponse =
        await postsRepository.setPostLiked(
          postId: postId,
        );

        // todo:
        if (postLikeResponse.error == null) {
          emit(
            PostLikeState.success(
              postId: postId,
              isLiked: isLiked,
              likeCnt: likeCnt,
            ),
          );
        } else {
          emit(
            PostLikeState.failure(
              error: postLikeResponse.error,
              postId: postId,
              isLiked: likeWas,
              likeCnt: likeCntWas,
            ),
          );
        }
      } else {
        final RemoveLikeResponse removeLikeResponse =
        await postsRepository.removePostLiked(
          postId: postId,
        );

        if (removeLikeResponse.error == null) {
          emit(
            PostLikeState.success(
              postId: postId,
              isLiked: isLiked,
              likeCnt: likeCnt,
            ),
          );
        } else {
          emit(
            PostLikeState.failure(
              error: removeLikeResponse.error,
              postId: postId,
              isLiked: likeWas,
              likeCnt: likeCntWas,
            ),
          );
        }
      }
    } catch (error, trace) {
      print('catch PostLikeBloc error: $error - $trace');

      emit(
        PostLikeState.failure(
          error: error.toString(),
          postId: postId,
          isLiked: likeWas,
          likeCnt: likeCntWas,
        ),
      );
    }
  }
}
