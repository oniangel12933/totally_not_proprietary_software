import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:involio/gen/involio_api.swagger.dart';

part 'user_search_event.dart';

part 'user_search_state.dart';

class UserSearchBloc extends Bloc<UserSearchEvent, UserSearchState> {
  UserSearchBloc() : super(UserSearchStateInitial()) {
    on<UserSearchEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
