import 'package:get_it/get_it.dart';

import 'package:involio/src/repositories/api/api_client/api_client.dart';
import 'package:involio/src/repositories/api/auth/auth_repository.dart';
import 'package:involio/src/repositories/api/portfolios/portfolios_repository.dart';
import 'package:involio/src/repositories/api/posts/posts_repository.dart';
import 'package:involio/src/repositories/api/strategies/strategies_repository.dart';
import 'package:involio/src/repositories/api/user/user_repository.dart';
import 'package:involio/src/repositories/local/secure_storage/secure_repository.dart';
import 'package:involio/src/shared/blocs/auth_bloc/auth_bloc.dart';
import 'app_config.dart';

Future<void> getItSetUp({bool testing = false}) async {
  final getIt = GetIt.instance;

  if (testing) {
    // can setup mocks here
  }

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
    dispose: (AuthRepository ar) => ar.dispose(),
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
  getIt.registerLazySingleton<PortfoliosRepository>(
        () => PortfoliosRepository(),
  );
  getIt.registerLazySingleton<StrategiesRepository>(
        () => StrategiesRepository(),
  );

  getIt.registerLazySingleton<AuthBloc>(
        () => AuthBloc(),
    dispose: (AuthBloc authBloc) => authBloc.close(),
  );

  return getIt.allReady();
}
