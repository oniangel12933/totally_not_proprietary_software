import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_dotenv/src/errors.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:involio/src/shared/blocs/bloc_observer.dart';
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

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  BlocOverrides.runZoned(
    () => HydratedBlocOverrides.runZoned(
      () => runApp(const MyApp()),
      storage: storage,
    ),
    blocObserver: AppBlocObserver(),
  );
}
