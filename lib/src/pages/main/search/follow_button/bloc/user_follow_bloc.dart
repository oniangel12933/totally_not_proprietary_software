import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:involio/gen/involio_api.swagger.dart';
import 'package:involio/src/pages/main/search/follow_button/bloc/user_follow_event.dart';
import 'package:involio/src/pages/main/search/follow_button/bloc/user_follow_state.dart';
import 'package:involio/src/repositories/api/user/user_repository.dart';
import 'package:involio/src/shared/blocs/event_transformers/throttle.dart';

const throttleDuration = Duration(milliseconds: 200);

class UserFollowBloc extends Bloc<UserFollowEvent, UserFollowState> {
  void followButtonPressed({
    String? userId,
    bool? wasFollowing,
    int? followersCntWas,
  }) {
    add(
      UserFollowEvent.buttonPressed(
        userId: userId,
        wasFollowing: wasFollowing,
        followersCntWas: followersCntWas,
      ),
    );
  }

  UserFollowBloc({
    required userId,
    required isFollowing,
    required followersCnt,
  }) : super(UserFollowState.initial(
          userId: userId,
          isFollowing: isFollowing,
          followersCnt: followersCnt,
        )) {
    on<UserFollowButtonPressedEvent>(
      _onFollowButtonPressed,
      transformer: throttle(throttleDuration),
    );
  }

  void _onFollowButtonPressed(
    UserFollowButtonPressedEvent event,
    Emitter<UserFollowState> emit,
  ) async {
    final String userId = event.userId ?? state.userId;

    final bool wasFollowing = event.wasFollowing ?? state.isFollowing;
    bool isFollowing = !wasFollowing;

    final int followersCntWas = event.followersCntWas ?? state.followersCnt;
    int followersCnt = isFollowing ? followersCntWas + 1 : followersCntWas - 1;

    emit(
      UserFollowState.saving(
        userId: userId,
        isFollowing: isFollowing,
        followersCnt: followersCnt,
      ),
    );

    try {
      UserRepository userRepository = GetIt.I.get<UserRepository>();

      if (isFollowing) {
        final CreateFollowResponse response =
            await userRepository.followUser(userId: userId);

        if (response.error == null) {
          emit(
            UserFollowState.success(
              userId: userId,
              isFollowing: isFollowing,
              followersCnt: followersCnt,
            ),
          );
        } else {
          emit(
            UserFollowState.failure(
              error: response.error,
              userId: userId,
              isFollowing: isFollowing,
              followersCnt: followersCnt,
            ),
          );
        }
      } else {
        final CreateFollowResponse response =
            await userRepository.unfollowUser(userId: userId);

        if (response.error == null) {
          emit(
            UserFollowState.success(
              userId: userId,
              isFollowing: isFollowing,
              followersCnt: followersCnt,
            ),
          );
        } else {
          emit(
            UserFollowState.failure(
              error: response.error,
              userId: userId,
              isFollowing: isFollowing,
              followersCnt: followersCnt,
            ),
          );
        }
      }
    } catch (error, trace) {
      print('catch PostLikeBloc error: $error - $trace');

      emit(
        UserFollowState.failure(
          error: error.toString(),
          userId: userId,
          isFollowing: isFollowing,
          followersCnt: followersCnt,
        ),
      );
    }
  }
}
