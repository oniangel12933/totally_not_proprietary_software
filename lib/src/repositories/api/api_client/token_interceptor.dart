import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:insidersapp/src/repositories/local/secure_storage/secure_repository.dart';

class TokenInterceptor extends Interceptor {
  final Dio dio;
  final getIt = GetIt.instance;

  TokenInterceptor(this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var accessToken = await getIt.get<SecureStorageRepository>().getToken();

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

      print('TokenInterceptor **** $accessToken');
    }

    return handler.next(options);
  }
}
