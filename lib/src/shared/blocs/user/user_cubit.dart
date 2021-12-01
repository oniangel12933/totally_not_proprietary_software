import 'package:bloc/bloc.dart';
import 'package:insidersapp/src/repositories/api/user/models/get_user_response.dart';
import 'package:insidersapp/src/repositories/api/user/user_repository.dart';
import 'cubit.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;

  UserCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const UserState());

  Future<GetUserResponse?> getUser() async {
    //print('UserCubit -> getUser()');
    GetUserResponse user = await _userRepository.getUser();
    emit(UserState(user: user));
  }
}
