import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:insidersapp/src/repositories/api/api_client/curl_interceptor.dart';
import 'package:insidersapp/src/repositories/api/api_client/retry_interceptor.dart';
import 'package:insidersapp/src/repositories/api/api_client/token_interceptor.dart';
import 'package:insidersapp/src/shared/config/app_config.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


class Api {
  final dio = _createDioClient();

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio _createDioClient() {
    var dio = Dio(BaseOptions(
      baseUrl: GetIt.instance
          .get<AppConfig>()
          .baseUrl,
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
      getCurlLoggerInterceptor(),
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
