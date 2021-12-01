import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:insidersapp/src/repositories/api/user/models/get_user_response.dart';
import 'package:insidersapp/src/repositories/api/user/user_repository.dart';
import 'cubit.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState());

  Future<GetUserResponse?> getUser() async {
    //print('UserCubit -> getUser()');
    GetUserResponse user = await GetIt.I.get<UserRepository>().getUser();
    emit(UserState(user: user));
  }
}
