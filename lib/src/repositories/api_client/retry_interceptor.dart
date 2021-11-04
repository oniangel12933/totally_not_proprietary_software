import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

/// https://github.com/SimpleBoilerplates/Flutter/
class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (_shouldRetry(err)) {
      try {
        requestRetrier.scheduleRequestRetry(err.requestOptions);
      } catch (e) {}
    }
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.connectTimeout &&
        err.error != null &&
        err.error is SocketException;
  }
}

class DioConnectivityRequestRetrier {
  final Dio dio;

  final Connectivity connectivity;

  DioConnectivityRequestRetrier({
    required this.dio,
    required this.connectivity,
  });

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    late StreamSubscription streamSubscription;
    final responseCompleter = Completer<Response>();
    streamSubscription = connectivity.onConnectivityChanged.listen(
          (connectivityResult) {
        if (connectivityResult != ConnectivityResult.none) {
          streamSubscription.cancel();

          responseCompleter.complete(
            dio.request(requestOptions.path,
                cancelToken: requestOptions.cancelToken,
                data: requestOptions.data,
                onReceiveProgress: requestOptions.onReceiveProgress,
                onSendProgress: requestOptions.onSendProgress,
                queryParameters: requestOptions.queryParameters,
                options: Options(
                    method: requestOptions.method,
                    sendTimeout: requestOptions.sendTimeout,
                    receiveTimeout: requestOptions.receiveTimeout,
                    extra: requestOptions.extra,
                    headers: requestOptions.headers,
                    responseType: requestOptions.responseType,
                    contentType: requestOptions.contentType,
                    validateStatus: requestOptions.validateStatus,
                    receiveDataWhenStatusError:
                    requestOptions.receiveDataWhenStatusError,
                    followRedirects: requestOptions.followRedirects,
                    maxRedirects: requestOptions.maxRedirects,
                    requestEncoder: requestOptions.requestEncoder,
                    responseDecoder: requestOptions.responseDecoder,
                    listFormat: requestOptions.listFormat)),
          );
        }
      },
    );

    return responseCompleter.future;
  }
}