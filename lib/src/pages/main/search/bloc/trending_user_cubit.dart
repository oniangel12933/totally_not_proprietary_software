import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import 'package:involio/gen/involio_api.swagger.dart';
import 'package:involio/src/repositories/api/user/user_repository.dart';

part 'trending_user_state.dart';

class TrendingUserCubit extends Cubit<TrendingUserState> {
  int pageSize;

  TrendingUserCubit({required this.pageSize}) : super(TrendingUserInitial()) {
    getData();
  }

  Future<void> getData() async {
    final TrendingUserResponse userResponse = await GetIt.I
        .get<UserRepository>()
        .getTrendingUsers(size: pageSize, page: 1);

    if (userResponse.items == null) {
      emit(const TrendingUserState(data: []));
    } else {
      emit(TrendingUserState(data: userResponse.items ?? []));
    }
  }
}
