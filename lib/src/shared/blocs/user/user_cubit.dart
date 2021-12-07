import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:insidersapp/gen/involio_api.swagger.dart';
import 'package:insidersapp/src/repositories/api/user/user_repository.dart';
import 'cubit.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState());

  Future<UserResponse?> getUser() async {
    //print('UserCubit -> getUser()');
    UserResponse user = await GetIt.I.get<UserRepository>().getUser();
    emit(UserState(user: user));
  }
}
