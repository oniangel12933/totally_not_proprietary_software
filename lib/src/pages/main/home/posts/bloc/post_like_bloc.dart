import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:insidersapp/src/pages/main/home/posts/bloc/post_like_event.dart';
import 'package:insidersapp/src/pages/main/home/posts/bloc/post_like_state.dart';
import 'package:insidersapp/src/repositories/posts/posts/post_like_response.dart';
import 'package:insidersapp/src/repositories/posts/posts_repository.dart';
import 'package:insidersapp/src/shared/blocs/event_transformers/throttle.dart';

const throttleDuration = Duration(milliseconds: 200);

class PostLikeBloc extends Bloc<PostLikeEvent, PostLikeState> {
  final getIt = GetIt.instance;

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
          like: liked,
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

    final bool likeWas = event.likeWas ?? state.like;
    bool like = false;

    final int likeCntWas = event.likeCntWas ?? state.likeCnt;
    int likeCnt = likeCntWas;

    if (likeWas == true) {
      likeCnt = likeCntWas - 1;
    }

    if (likeWas == false) {
      likeCnt = likeCntWas + 1;
      like = true;
    }

    emit(
      PostLikeState.saving(
        postId: postId,
        like: like,
        likeCnt: likeCnt,
      ),
    );

    try {
      PostsRepository postsRepository = getIt.get<PostsRepository>();
      final PostLikeResponse postLikeResponse =
          await postsRepository.setPostLiked(
        postId: postId,
      );

      //todo: have backend return boolean and combine add and remove like
      if (postLikeResponse.success == "True") {
        emit(
          PostLikeState.success(
            postId: postId,
            like: like, // result
            likeCnt: likeCnt, // result
          ),
        );
      } else {
        emit(
          PostLikeState.failure(
            error: postLikeResponse.error,
            postId: postId,
            like: likeWas,
            likeCnt: likeCntWas,
          ),
        );
      }
    } catch (error, trace) {
      print('catch PostLikeBloc error: $error - $trace');

      emit(
        PostLikeState.failure(
          error: error.toString(),
          postId: postId,
          like: likeWas,
          likeCnt: likeCntWas,
        ),
      );
    }
  }
}
