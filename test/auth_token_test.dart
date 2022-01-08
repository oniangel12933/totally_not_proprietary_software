import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import 'package:involio/src/repositories/api/api_client/token_with_refresh_interceptor.dart';
import 'package:involio/src/repositories/local/secure_storage/secure_repository.dart';
import 'package:involio/src/shared/config/app_config.dart';
import 'package:involio/src/shared/config/get_it_setup.dart';

class MockDioResponse extends Mock implements Response {}

class MockRequestHandler extends Mock implements RequestInterceptorHandler {}

class MockResponseHandler extends Mock implements ResponseInterceptorHandler {}

class MockErrorHandler extends Mock implements ErrorInterceptorHandler {}
class MockDioError extends Mock implements DioError {}

class MockDioClient extends Mock implements Dio {}

class MockSecureStorageRepository extends Mock
    implements SecureStorageRepository {}

void main() {
  const authKey = 'Authorization';

  late MockDioClient refreshDio;

  late RequestOptions options;
  late TokenWithRefreshInterceptor tokenWithRefreshInterceptor;

  late MockSecureStorageRepository mockStorage;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    //String envPath = Assets.env.envDevelopment;
    //bool fileExists = await io.File(envPath).exists();
    //print("$envPath exists=$fileExists");

    //var envString = await rootBundle.loadString(envPath);
    //print(envString);

    //await dotenv.load(fileName: envPath);

    // this will load a blank config and use the defaults set in app config
    dotenv.testLoad();
    await getItSetUp(testing: true);

    GetIt.I.unregister<SecureStorageRepository>();
    mockStorage = MockSecureStorageRepository();
    GetIt.I.registerLazySingleton<SecureStorageRepository>(() {
      return mockStorage;
      //when(() => mockStorage.getAccessToken()).thenAnswer((_) => Future<String>(() => 'fake_access_token_1'));
      //return mockStorage;
    });

    refreshDio = MockDioClient();

    // interceptor = AuthInterceptor(
    //   userService: userService,
    //   configService: configService,
    // );

    tokenWithRefreshInterceptor = TokenWithRefreshInterceptor(
      refreshDio: refreshDio,
    );
  });

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    options = RequestOptions(path: GetIt.I.get<AppConfig>().baseUrl);
  });

  test(
    'Request authorization header should not be inserted if the access token is null',
    () async {
      when(() => mockStorage.getAccessToken())
          .thenAnswer((_) => Future<String?>(() => null));
      final MockRequestHandler handler = MockRequestHandler();
      await tokenWithRefreshInterceptor.onRequest(options, handler);
      final VerificationResult result = verify(() => handler.next(options))
        ..called(1);
      expect(options.headers[authKey], isNull);
    },
  );

  test(
    'Request authorization header should have bear token when not null',
    () async {
      String? accessToken = 'fake_access_token_1';
      when(() => mockStorage.getAccessToken())
          .thenAnswer((_) => Future<String?>(() => accessToken));
      final MockRequestHandler handler = MockRequestHandler();
      await tokenWithRefreshInterceptor.onRequest(options, handler);
      final VerificationResult result = verify(() => handler.next(options))
        ..called(1);
      expect(options.headers[authKey], 'Bearer $accessToken');
    },
  );

  // test(
  //   'Request authorization error',
  //       () async {
  //     String? accessToken1 = 'fake_access_token_1';
  //     String? accessToken2 = 'fake_access_token_2';
  //     String? refreshToken = 'fake_refresh_token_1';
  //     when(() => mockStorage.getAccessToken())
  //         .thenAnswer((_) => Future<String?>(() => accessToken1));
  //     when(() => mockStorage.getRefreshToken())
  //         .thenAnswer((_) => Future<String?>(() => refreshToken));
  //
  //
  //     final MockErrorHandler handler = MockErrorHandler();
  //     final MockDioError err = MockDioError();
  //     err.response = MockDioResponse();
  //
  //     when(() => refreshDio.fetch(err.requestOptions))
  //         .thenAnswer((_) => Future<Response>(() => MockDioResponse()));
  //
  //     await tokenWithRefreshInterceptor.onError(err, handler);
  //     final VerificationResult result = verify(() => handler.resolve(err.response!))
  //       ..called(1);
  //
  //     //expect(options.headers[authKey], isNull);
  //     //expect(options.headers[authKey], 'Bearer $accessToken');
  //   },
  // );
}
