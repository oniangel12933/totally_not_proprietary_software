import 'package:bloc/bloc.dart';
import 'package:insidersapp/src/pages/main/home/posts/bloc/post_like_event.dart';
import 'package:insidersapp/src/pages/main/home/posts/bloc/post_like_state.dart';
import 'package:insidersapp/src/repositories/user/models/posts/post_like_response.dart';
import 'package:insidersapp/src/repositories/user/user_repository.dart';
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

    //print('mapEventToState CreateEventButtonPressed loading $state');

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

    //int like = likeData[UserToEventModel.LIKE];
    //String postId = likeData[UserToEventModel.EVENT_ID];

    try {
      //DFEventModel dfEventModel = await wydf.api.dfEvent.createNewDFEvent(data);
      //UserToEventModel userToEvent = await wydf.api.dfEvent.setGoing(postId: postId, going: going);

      //print('---event post bloc: is PostLikeButtonPressed: postId=$postId like=$like');

      // final Map<String, dynamic> userToEventMap = await wydf.api.dfEventApi
      //     .setUserEventReaction(postId: postId, like: like);

      //todo: get repository a better way then creating a new one
      final PostLikeResponse postLikeResponse =
          await UserRepository().setPostLiked(
        postId: postId,
      );

      //final UserToEventModel userToEvent = userToEventMap['userToEvent'];
      //final DFEventModel dfEvent = userToEvent.mEvent;

      //todo: have backend return boolean and combine add and remove like
      if (postLikeResponse.success == "True") {
        emit(
          PostLikeState.success(
            // userToEvent: userToEvent,
            // dfEvent: dfEvent,
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
      //print('mapEventToState CreateEventButtonPressed success after $state');
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
