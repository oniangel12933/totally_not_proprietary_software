import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import 'package:involio/src/repositories/api/api_client/api_client.dart';
import 'package:involio/src/repositories/api/user/user_repository.dart';
import 'package:involio/src/repositories/local/secure_storage/secure_repository.dart';
import 'package:involio/src/shared/cache/cache.dart';
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

class MockSimpleCache extends Mock implements SimpleCache {}

void main() {
  late RequestOptions options;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    // this will load a blank config and use the defaults set in app config
    dotenv.testLoad();
    await getItSetUp(testing: true);
  });

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    options = RequestOptions(path: GetIt.I.get<AppConfig>().baseUrl);
  });

  test(
    'getUser() retrieves user from network api if it is not in the cache',
    () async {
      GetIt.I.unregister<SimpleCache>();
      MockSimpleCache simpleCache;
      simpleCache = MockSimpleCache();
      GetIt.I.registerLazySingleton<SimpleCache>(() {
        when(() => simpleCache.getString(UserRepository.userCacheKey))
            .thenAnswer(
          (_) => Future<String?>(() => null),
        );

        when(() => simpleCache.setString(
            key: UserRepository.userCacheKey,
            value: any(named: 'value'))).thenAnswer(
          (_) => Future<bool>(() => true),
        );

        return simpleCache;
      });

      GetIt.I.unregister<Api>();
      MockDioClient mockDio = MockDioClient();
      GetIt.I.registerLazySingleton<Api>(() {
        when(() => mockDio.get(any())).thenAnswer(
          (invocation) => Future.value(Response(
            data: <String, dynamic>{},
            requestOptions: options,
          )),
        );
        Api api = Api.testing(dio: mockDio);
        return api;
      });

      UserRepository userRepository = UserRepository();
      await userRepository.getUser();

      final VerificationResult cacheCalledResult =
          verify(() => simpleCache.getString(UserRepository.userCacheKey))
            ..called(1);

      final VerificationResult networkCalledResult =
          verify(() => mockDio.get(captureAny()))..called(1);

      // make sure that we cache the new result
      final VerificationResult addToCacheResult = verify(() =>
          simpleCache.setString(
              key: UserRepository.userCacheKey, value: any(named: "value")))
        ..called(1);
    },
  );

  test(
    'getUser() retrieves cache if it is in the cache',
    () async {
      GetIt.I.unregister<SimpleCache>();
      MockSimpleCache simpleCache;
      simpleCache = MockSimpleCache();
      GetIt.I.registerLazySingleton<SimpleCache>(() {
        when(() => simpleCache.getString(
              UserRepository.userCacheKey,
            )).thenAnswer((_) => Future<String?>(() => '{}'));
        return simpleCache;
      });

      GetIt.I.unregister<Api>();
      MockDioClient mockDio = MockDioClient();
      GetIt.I.registerLazySingleton<Api>(() {
        when(() => mockDio.get(any())).thenAnswer(
          (invocation) => Future.value(Response(
            data: <String, dynamic>{},
            requestOptions: options,
          )),
        );
        Api api = Api.testing(dio: mockDio);
        return api;
      });

      UserRepository userRepository = UserRepository();
      await userRepository.getUser();

      final VerificationResult cacheCalledResult =
          verify(() => simpleCache.getString(UserRepository.userCacheKey))
            ..called(1);

      final VerificationResult networkCalledResult =
          verifyNever(() => mockDio.get(captureAny()));
    },
  );
}
