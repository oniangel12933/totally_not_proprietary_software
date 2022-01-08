import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_dotenv/src/errors.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:involio/src/shared/blocs/bloc_observer.dart';
import 'package:involio/src/shared/config/app_config.dart';
import 'package:involio/src/shared/config/get_it_setup.dart';
import 'src/app.dart';

void main() async {

  try {
    await dotenv.load(fileName: 'assets/env/.env');
  } on FileNotFoundError {
    // this will load a blank config and use the defaults set in app config
    dotenv.testLoad();
  }
  await getItSetUp();

  // make sure that widget bindings are initialized before running app
  // this prevents possible exceptions
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(), // await getApplicationDocumentsDirectory(),
  );

  final info = await PackageInfo.fromPlatform();
  AppConfig config = GetIt.I.get<AppConfig>();

  if (config.isProduction) {
    runZonedGuarded(() async {
      await SentryFlutter.init(
        (options) {
          options.dsn =
              'https://e596a03b40004951866192544e6ad176@o1076368.ingest.sentry.io/6078206';
          options.release = '${info.version}+${info.buildNumber}';
          options.environment = "prod";
          // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
          // We recommend adjusting this value in production. default is null.
          //options.tracesSampleRate = 1.0;
          //options.reportPackages = false;
        },
      );

      BlocOverrides.runZoned(
        () => HydratedBlocOverrides.runZoned(
          () => runApp(const MyApp()),
          storage: storage,
        ),
        blocObserver: AppBlocObserver(),
      );
    }, (exception, stackTrace) async {
      await Sentry.captureException(exception, stackTrace: stackTrace);
    });
  } else {
    BlocOverrides.runZoned(
      () => HydratedBlocOverrides.runZoned(
        () => runApp(const MyApp()),
        storage: storage,
      ),
      blocObserver: AppBlocObserver(),
    );
  }
}
