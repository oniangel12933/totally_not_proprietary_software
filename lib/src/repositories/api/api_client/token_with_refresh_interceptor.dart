import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:involio/gen/involio_api.swagger.dart';
import 'package:involio/src/repositories/local/secure_storage/secure_repository.dart';
import 'package:involio/src/shared/blocs/auth_bloc/auth_bloc.dart';

/// This will use the access token in the auth header to complete the request.
/// If the access token is expired, it will use the refresh token to get a
/// new access token. If the refresh token is expired, it will take the user
/// back to the login page.
class TokenWithRefreshInterceptor extends Interceptor {
  final Dio refreshDio;

  TokenWithRefreshInterceptor({required this.refreshDio});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? accessToken =
        await GetIt.I.get<SecureStorageRepository>().getAccessToken();

    print("Using Access Token: $accessToken");

    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    print("now calling next");
    return handler.next(options);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    print("TokenWithRefreshInterceptor onError $err");

    int? statusCode = err.response?.statusCode;

    if (err.response?.statusCode == 401) {
      Response? refreshResponse;

      try {
        refreshResponse = await refreshDio.post('api/auth/refresh_token');
        statusCode = refreshResponse.statusCode;
      } on DioError catch (e) {
        //print(e.toString());
        statusCode = e.response?.statusCode;
      }

      //print("in refreshToken() statusCode=$statusCode = refreshResponse=$refreshResponse");

      if (statusCode == 200) {
        final RefreshTokenResponse refreshTokenResponse =
            RefreshTokenResponse.fromJson(refreshResponse?.data);
        if (refreshTokenResponse.error != null &&
            refreshTokenResponse.error!.isNotEmpty) {
          print(refreshTokenResponse.error);
        }

        String? accessToken = refreshTokenResponse.accessToken;

        if (accessToken != null && accessToken.isNotEmpty) {
          print("Saving Access Token: $accessToken");
          await GetIt.I
              .get<SecureStorageRepository>()
              .persistAccessToken(accessToken);

          err.requestOptions.headers['Authorization'] = 'Bearer $accessToken';
          final Response response = await refreshDio.fetch(err.requestOptions);
          return handler.resolve(response);
        } else {
          print("received empty access token");
          return handler.reject(err);
        }
      } else if (statusCode == 401) {
        print("Refresh Token not Authenticated, Logging Out.");
        GetIt.I.get<AuthBloc>().setLoggedOut();
        return handler.reject(err);
      }
    }
    print("Error code not handled by refresh interceptor $statusCode");
    return handler.reject(err);
  }
}
