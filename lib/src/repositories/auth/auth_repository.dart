import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:insidersapp/src/repositories/auth/models/otp_sms_start_request.dart';
import 'package:insidersapp/src/repositories/auth/models/otp_sms_start_response.dart';

import '../api_client/api_client.dart';
import 'models/otp_sms_login_request.dart';
import 'models/otp_sms_login_response.dart';
import 'models/sign_up_request.dart';
import 'models/sign_up_response.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthRepository {
  final _controller = StreamController<AuthStatus>();

  Stream<AuthStatus> get status async* {
    // todo check in secure storage for user token and check if it is expired

    //await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<OtpSmsLoginResponse> logInWithPhone({
     required String phone,
     required String password,
   }) async {

    OtpSmsLoginRequest request = OtpSmsLoginRequest(phone: phone, code: password);

    Response response = await Api()
        .dio
        .post('api/auth/login/sms', data: jsonEncode(request.toJson()));

    // print('AuthRepo logInWithPhone 2 --------');
    // print(response.data);

    OtpSmsLoginResponse responseModel = OtpSmsLoginResponse.fromJson(response.data);

    if (responseModel.access_token != null) {

    }

    return OtpSmsLoginResponse.fromJson(response.data);
  }

  /// https://api.insidersapp.io/docs#/auth/otp_start_api_auth_login_sms_start_post
  /// https://api.insidersapp.io/api/auth/login/sms/start
  Future<OtpSmsStartResponse> getOtpForPhoneNumber({
    required String phone,
  }) async {
    OtpSmsStartRequest request = OtpSmsStartRequest(phone: phone);
    Response response = await Api()
        .dio
        .post('api/auth/login/sms/start', data: jsonEncode(request.toJson()));

    // this triggers a login
    // await Future.delayed(
    //   const Duration(milliseconds: 300),
    //   () => _controller.add(AuthenticationStatus.authenticated),
    // );

    return OtpSmsStartResponse.fromJson(response.data);
  }

  /// https://api.insidersapp.io/docs#/auth/create_user_api_auth_signup_post
  /// https://api.insidersapp.io/api/auth/signup
  Future<SignUpResponse> signUpNewUser({
    String? email,
    required String username,
    required String phone,
    required String name,
    required String birthdate,
  }) async {
    SignUpRequest request = SignUpRequest(
      email: email,
      username: username,
      phone: phone,
      name: name,
      birthdate: birthdate,
    );

    print("#############################");
    print(request);

    Response response = await Api()
        .dio
        .post('api/auth/signup', data: jsonEncode(request.toJson()));

    return SignUpResponse.fromJson(response.data);
  }

  void logOut() {
    _controller.add(AuthStatus.unauthenticated);
  }

  void dispose() => _controller.close();

  Future<void> refresh() async {}
}
