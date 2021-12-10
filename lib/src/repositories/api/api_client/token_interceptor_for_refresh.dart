import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:insidersapp/src/repositories/local/secure_storage/secure_repository.dart';

class TokenInterceptorForRefresh extends Interceptor {
  TokenInterceptorForRefresh();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var accessToken = await GetIt.I.get<SecureStorageRepository>().getRefreshToken();

    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return handler.next(options);
  }
}
