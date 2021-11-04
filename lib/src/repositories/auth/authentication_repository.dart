import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:insidersapp/src/repositories/auth/models/otp_sms_start_request.dart';
import 'package:insidersapp/src/repositories/auth/models/otp_sms_start_response.dart';

import '../api_client/api.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    // todo check in secure storage for user token and check if it is expired

    //await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  // Future<LoginResponse> login({
  //   required LoginRequest request,
  // }) async {
  //   await Future<dynamic>.delayed(const Duration(seconds: 1));
  //   //return 'token';
  //   return LoginResponse(email: request.email, jwt: 'token_345435');
  // }

  // Future<void> logIn({
  //   required String username,
  //   required String password,
  // }) async {
  //   await Future.delayed(
  //     const Duration(milliseconds: 300),
  //     () => _controller.add(AuthenticationStatus.authenticated),
  //   );
  // }

  // Future<LoginResponse> logIn({
  //    required String phone,
  //    required String password,
  //  }) async {
  //   var response = await Api().dio.get('login');
  //
  //   return LoginResponse.fromJson(response.data);
  // }

  /// https://api.insidersapp.io/api/auth/login/sms/start
  Future<OtpSmsStartResponse> getOtpForPhoneNumber({
    required String phone,
  }) async {
    OtpSmsStartRequest request = OtpSmsStartRequest(phone: phone);
    Response response = await Api()
        .dio
        .post('auth/login/sms/start', data: jsonEncode(request.toJson()));

    // this triggers a login
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );

    return OtpSmsStartResponse.fromJson(response.data);
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();

  Future<void> refresh() async {}
}
