import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:involio/src/repositories/api/api_client/curl_interceptor.dart';
import 'package:involio/src/repositories/api/api_client/token_interceptor_for_refresh.dart';
import 'package:involio/src/repositories/api/api_client/token_with_refresh_interceptor.dart';
import 'package:involio/src/shared/config/app_config.dart';
import 'error_interceptor.dart';

class Api {
  late final Dio dio;

  // final options = CacheOptions(
  //   // A default store is required for interceptor.
  //   store: MemCacheStore(),
  //   // Default.
  //   policy: CachePolicy.request,
  //   // Optional. Returns a cached response on error but for statuses 401 & 403.
  //   hitCacheOnErrorExcept: [401, 403],
  //   // Optional. Overrides any HTTP directive to delete entry past this duration.
  //   maxStale: const Duration(days: 7),
  //   // Default. Allows 3 cache sets and ease cleanup.
  //   priority: CachePriority.normal,
  //   // Default. Body and headers encryption with your own algorithm.
  //   cipher: null,
  //   // Default. Key builder to retrieve requests.
  //   keyBuilder: CacheOptions.defaultCacheKeyBuilder,
  //   // Default. Allows to cache POST requests.
  //   // Overriding [keyBuilder] is strongly recommended.
  //   allowPostMethod: false,
  // );

  // Api._internal() {
  //   dio = _createDioClient();
  // }
  //
  // //static final _singleton = Api._internal();
  // //factory Api() => _singleton;
  //
  // factory Api() {
  //   return Api._internal();
  // }
  //
  // factory Api.testing(Dio dio) {
  //   return Api._internal();
  // }
  //
  //

  Api() {
    dio = _createDioClient();
  }

  Api.testing({required this.dio});

  static Dio _getBaseClient() {
    Dio dioNew = Dio(BaseOptions(
      baseUrl: GetIt.I.get<AppConfig>().baseUrl,
      receiveTimeout: 15000, // 15 seconds
      connectTimeout: 15000,
      sendTimeout: 15000,
    ));

    if (!AppConfig().isProduction) {
      /// if not production, allow non valid ssl cert from server on local box
      (dioNew.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
    return dioNew;
  }

  static Dio _createDioClient() {
    Dio _dio = _getBaseClient();
    Dio _refreshDio = _createRefreshDioClient();

    _dio.interceptors.addAll({
      TokenWithRefreshInterceptor(refreshDio: _refreshDio),
      ..._getSharedInterceptors(dio: _dio),
    });
    return _dio;
  }

  static Dio _createRefreshDioClient() {
    var _dio = _getBaseClient();

    _dio.interceptors.addAll({
      TokenInterceptorForRefresh(),
      ..._getSharedInterceptors(dio: _dio),
    });
    return _dio;
  }

  static _getSharedInterceptors({required Dio dio}) {
    //final MemoryCacheStore store = newMemoryCacheStore();
    //final cache = store.cache(eventListenerMode: EventListenerMode.synchronous);
    //cache.on<CacheEntryCreatedEvent>().listen((event) => print('Key "${event.entry.key}" added to the cache'));

    return {
      //cache.interceptor('/api/social/feed/get_post_feed'),
      PrettyDioLogger(
          //requestHeader: true,
          requestBody: true,
          responseBody: true,
          //responseHeader: false,
          error: true,
          //compact: true,
          maxWidth: 120,
      ),
      getCurlLoggerInterceptor(),
      // RetryInterceptor(
      //   dio: dio,
      //   logPrint: print, // specify log function (optional)
      //   retries: 3, // retry count (optional)
      //   retryDelays: const [ // set delays between retries (optional)
      //     Duration(seconds: 1), // wait 1 sec before first retry
      //     Duration(seconds: 2), // wait 2 sec before second retry
      //     Duration(seconds: 3), // wait 3 sec before third retry
      //   ],
      // ),
      //DioCacheInterceptor(options: options),
      //ErrorInterceptor(),
    };
  }
}
