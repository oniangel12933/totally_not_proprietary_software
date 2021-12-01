import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:insidersapp/src/repositories/api/api_client/api_client.dart';
import 'models/get_user_response.dart';
import 'models/models.dart';

class UserRepository {
  final getIt = GetIt.instance;
  User? _user;

  // Future<User?> getUser() async {
  //   if (_user != null) return _user;
  //   return Future.delayed(
  //     const Duration(milliseconds: 300),
  //     () => _user = User(const Uuid().v4()),
  //   );
  // }

  Future<GetUserResponse> getUser() async {
    Response response = await getIt.get<Api>().dio.get('api/user/get_user');

    return GetUserResponse.fromJson(response.data);
  }
}