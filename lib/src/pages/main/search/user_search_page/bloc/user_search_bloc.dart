import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import 'package:involio/gen/involio_api.swagger.dart';
import 'package:involio/src/repositories/api/user/user_repository.dart';
import 'package:involio/src/shared/blocs/event_transformers/debounce.dart';

part 'user_search_event.dart';

part 'user_search_state.dart';

class UserSearchBloc extends Bloc<UserSearchEvent, UserSearchState> {
  static Duration debounceDuration = const Duration(milliseconds: 400);

  void addUserSearchEvent({
    required String searchStr,
  }) {
    add(
      UserSearchEvent(
        searchStr: searchStr,
      ),
    );
  }

  UserSearchBloc() : super(UserSearchStateInitial()) {
    on<UserSearchEvent>(
      _onSearchEvent,
      transformer: debounce(debounceDuration),
    );
  }

  void _onSearchEvent(
    UserSearchEvent event,
    Emitter<UserSearchState> emit,
  ) async {
    String searchStr = event.searchStr.trim();

    if (searchStr.length < 3) {
      emit(const UserSearchState(data: []));
    } else {
      final UserSearchResponse userSearchResponse =
          await GetIt.I.get<UserRepository>().searchForUsers(
                searchStr: searchStr,
              );

      emit(UserSearchState(data: userSearchResponse.users ?? []));
    }
  }
}
