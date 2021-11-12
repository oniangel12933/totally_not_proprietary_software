import 'package:dio/dio.dart';
import 'package:insidersapp/src/repositories/api_client/api_client.dart';
import 'package:insidersapp/src/repositories/user/models/get_user_response.dart';
import 'package:uuid/uuid.dart';
import 'models/models.dart';

class UserRepository {
  User? _user;

  // Future<User?> getUser() async {
  //   if (_user != null) return _user;
  //   return Future.delayed(
  //     const Duration(milliseconds: 300),
  //     () => _user = User(const Uuid().v4()),
  //   );
  // }

  Future<GetUserResponse> getUser() async {
    Response response = await Api().dio.get('api/user/get_user');

    return GetUserResponse.fromJson(response.data);
  }
}
