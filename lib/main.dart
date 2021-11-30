import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:insidersapp/garb/settings_controller.dart';
import 'package:insidersapp/src/pages/settings/settings_service.dart';
import 'package:insidersapp/src/shared/config/get_it_setup.dart';
import 'package:path_provider/path_provider.dart';
import 'package:insidersapp/src/shared/blocs/bloc_observer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'gen/assets.gen.dart';
import 'src/app.dart';

void main() async {
  await dotenv.load(fileName: Assets.env.envDevelopment);
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

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

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
