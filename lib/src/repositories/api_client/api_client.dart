import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:insidersapp/src/repositories/api_client/retry_interceptor.dart';
import 'package:insidersapp/src/repositories/api_client/token_interceptor.dart';
import '../../shared/config/app_config.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'error_interceptor.dart';

/// https://medium.com/dreamwod-tech/flutter-dio-framework-best-practices-668985fc75b7
/// lib/api: Services are using an API class for communicating with the backend. We have two Dio clients in the class,
/// one is used for all requests except when the token is refreshed, then we use a dedicated Dio client.

class Api {
  final dio = _createDio();

  //static var tokenDio = Dio(BaseOptions(baseUrl: AppConfig().baseUrl));

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio _createDio() {
    final getIt = GetIt.instance;

    var dio = Dio(BaseOptions(
      baseUrl: getIt.get<AppConfig>().baseUrl,
      receiveTimeout: 15000, // 15 seconds
      connectTimeout: 15000,
      sendTimeout: 15000,
    ));

    dio.interceptors.addAll({
      TokenInterceptor(dio),
      PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          //responseHeader: false,
          error: true,
          //compact: true,
          maxWidth: 90),
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: dio,
          connectivity: Connectivity(),
        ),
      ),
      //ErrorInterceptor(dio),
    });
    return dio;
  }
}
