import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:involio/src/repositories/local/secure_storage/secure_repository.dart';

class TokenInterceptorForRefresh extends Interceptor {
  TokenInterceptorForRefresh();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var refreshToken = await GetIt.I.get<SecureStorageRepository>().getRefreshToken();

    print("using refresh token");
    if (refreshToken != null && refreshToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $refreshToken';
    }

    return handler.next(options);
  }
}
