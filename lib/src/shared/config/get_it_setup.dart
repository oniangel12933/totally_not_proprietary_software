import 'package:get_it/get_it.dart';

import 'package:insidersapp/src/repositories/api/api_client/api_client.dart';
import 'package:insidersapp/src/repositories/api/auth/auth_repository.dart';
import 'package:insidersapp/src/repositories/api/posts/posts_repository.dart';
import 'package:insidersapp/src/repositories/api/user/user_repository.dart';
import 'package:insidersapp/src/repositories/local/secure_storage/secure_repository.dart';
import 'app_config.dart';

final getIt = GetIt.instance;

Future<void> getItSetUp() async {
  getIt.registerSingletonAsync<AppConfig>(() async {
    AppConfig appConfig = AppConfig();
    await appConfig.setup();
    return appConfig;
  });

  getIt.registerLazySingleton<Api>(
    () => Api(),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(),
  );
  getIt.registerLazySingleton<SecureStorageRepository>(
    () => SecureStorageRepository(),
  );
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepository(),
  );
  getIt.registerLazySingleton<PostsRepository>(
    () => PostsRepository(),
  );

  return getIt.allReady();
}
