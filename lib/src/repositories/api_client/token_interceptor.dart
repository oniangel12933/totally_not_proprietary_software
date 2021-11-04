import 'package:dio/dio.dart';
import 'package:insidersapp/src/repositories/secure_storage/secure_repository.dart';

class TokenInterceptor extends Interceptor {
  final Dio dio;

  TokenInterceptor(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var accessToken = await SecureStorage().getToken();

    if (accessToken != null) {

      // Duration? expiration = await SecureStorage().getTokenRemainingTime();
      // if (expiration != null && expiration.inSeconds < 60) {
      //   dio.interceptors.requestLock.lock();
      //
      //   // Call the refresh endpoint to get a new token
      //   await AuthenticationRepository().refresh().then((response) async {
      //     await SecureStorage().persistToken(response.accessToken);
      //     accessToken = response.accessToken;
      //   }).catchError((error, stackTrace) {
      //     handler.reject(error, true);
      //   }).whenComplete(() => dio.interceptors.requestLock.unlock());
      // }

      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return handler.next(options);
  }
}
