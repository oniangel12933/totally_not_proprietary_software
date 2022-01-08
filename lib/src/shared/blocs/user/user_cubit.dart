import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:involio/gen/involio_api.swagger.dart';
import 'package:involio/src/repositories/api/user/user_repository.dart';
import 'cubit.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState());

  Future<UserBaseResponse?> getUser() async {
    //print('UserCubit -> getUser()');
    UserBaseResponse user = await GetIt.I.get<UserRepository>().getUser();
    emit(UserState(user: user));
  }
}
