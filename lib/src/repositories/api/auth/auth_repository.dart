import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:insidersapp/gen/involio_api.swagger.dart';
import 'package:insidersapp/src/repositories/api/api_client/api_client.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthRepository {
  final getIt = GetIt.instance;
  final _controller = StreamController<AuthStatus>();

  Stream<AuthStatus> get status async* {
    // todo check in secure storage for user token and check if it is expired

    //await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<OTPLoginResponse> logInWithPhone({
     required String phone,
     required String password,
   }) async {

    SMSLogin request = SMSLogin(phone: phone, code: password);

    Response response = await getIt.get<Api>()
        .dio
        .post('api/auth/login/sms', data: jsonEncode(request.toJson()));

    return OTPLoginResponse.fromJson(response.data);
  }

  /// https://api.insidersapp.io/docs#/auth/otp_start_api_auth_login_sms_start_post
  /// https://api.insidersapp.io/api/auth/login/sms/start
  Future<SMSStartResponse> getOtpForPhoneNumber({
    required String phone,
  }) async {
    SMSStart request = SMSStart(phone: phone);
    Response response = await getIt.get<Api>()
        .dio
        .post('api/auth/login/sms/start', data: jsonEncode(request.toJson()));

    // this triggers a login
    // await Future.delayed(
    //   const Duration(milliseconds: 300),
    //   () => _controller.add(AuthenticationStatus.authenticated),
    // );

    return SMSStartResponse.fromJson(response.data);
  }

  /// https://api.insidersapp.io/docs#/auth/create_user_api_auth_signup_post
  /// https://api.insidersapp.io/api/auth/signup
  Future<UserResponse> signUpNewUser({
    String? email,
    required String username,
    required String phone,
    required String name,
    required DateTime birthdate,
  }) async {
    UserCreate request = UserCreate(
      email: email,
      username: username,
      phone: phone,
      name: name,
      birthdate: birthdate,
    );

    Response response = await getIt.get<Api>()
        .dio
        .post('api/auth/signup', data: jsonEncode(request.toJson()));

    return UserResponse.fromJson(response.data);
  }

  void logOut() {
    _controller.add(AuthStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
