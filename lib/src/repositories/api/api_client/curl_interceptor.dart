import 'package:dio/dio.dart';

String cURLRepresentation(RequestOptions options) {
  List<String> components = [];

  components.add("curl -i -X '${options.method}'");
  components.add("'${options.uri.toString()}'");

  options.headers.forEach((k, v) {
    if (k != 'Cookie') {
      components.add('-H "$k: $v"');
    }
  });

  String data = options.data;
  components.add("-d '$data'");

  return components.join(' \\\n');
}

InterceptorsWrapper getCurlLoggerInterceptor() {
  return InterceptorsWrapper(
    onRequest: (
      RequestOptions requestOptions,
      RequestInterceptorHandler handler,
    ) {
      try {
        print(cURLRepresentation(requestOptions));
      } catch (err) {
        print('unable to create a CURL representation of the error');
      }
      return handler.next(requestOptions);
    },
    onError: (DioError e, handler) {
      try {
        print(cURLRepresentation(e.requestOptions));
      } catch (err) {
        print('unable to create a CURL representation of the error');
      }

      return handler.next(e);
    },
  );
}
