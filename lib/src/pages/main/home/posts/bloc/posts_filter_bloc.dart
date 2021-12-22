import 'package:bloc/bloc.dart';

import 'package:involio/src/pages/main/home/posts/bloc/posts_filter_event.dart';
import 'package:involio/src/pages/main/home/posts/bloc/posts_filter_state.dart';

class PostsFilterBloc extends Bloc<PostsFilterEvent, PostsFilterState> {
  void setFilter(String filterName) {
    add(PostsFilterEvent(filterName: filterName));
  }

  PostsFilterBloc({required String initialFilterName})
      : super(PostsFilterState(filterName: initialFilterName)) {
    on<PostsFilterEvent>((event, emit) {
      emit(PostsFilterState(filterName: event.filterName));
    });
  }
}
