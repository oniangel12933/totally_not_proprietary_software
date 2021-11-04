import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:insidersapp/src/pages/login/authentication.dart';
import 'package:insidersapp/src/pages/login/login.dart';
import 'package:insidersapp/src/pages/splash/splash_page.dart';
import 'package:insidersapp/src/repositories/auth/authentication_repository.dart';
import 'package:insidersapp/src/repositories/user/user_repository.dart';

import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
    required this.authenticationRepository,
    required this.userRepository,
  }) : super(key: key);

  final SettingsController settingsController;
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: widget.authenticationRepository),
        RepositoryProvider.value(value: widget.userRepository),
      ],
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: widget.authenticationRepository,
          userRepository: widget.userRepository,
        ),
        child: AppView(settingsController: widget.settingsController,
            navigatorKey: _navigatorKey),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
    required this.settingsController,
    required this.navigatorKey,
  }) : super(key: key);

  final SettingsController settingsController;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {

    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          navigatorKey: navigatorKey,

          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                  switch (state.status) {
                    case AuthenticationStatus.authenticated:
                      navigatorKey.currentState?.restorablePushNamedAndRemoveUntil(SampleItemListView.routeName, (route) => false);
                      break;
                    case AuthenticationStatus.unauthenticated:
                      navigatorKey.currentState?.restorablePushNamedAndRemoveUntil(LoginPage.routeName, (route) => false);
                      break;
                    default:
                      navigatorKey.currentState?.restorablePushNamedAndRemoveUntil(SampleItemListView.routeName, (route) => false);
                  }
              },
              child: child,
            );
          },

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {

                return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    print('state=$state!!!!!');
                    print('routeSettings.name=${routeSettings.name}!!!!!');
                    // switch (state.status) {
                    //   case AuthenticationStatus.authenticated:
                        switch (routeSettings.name) {
                          //case Navigator.defaultRouteName:
                          //  return SplashPage.route();
                          case LoginPage.routeName:
                            return const LoginPage();
                          case SettingsView.routeName:
                            return SettingsView(controller: settingsController);
                          case SampleItemDetailsView.routeName:
                            return const SampleItemDetailsView();
                          case SampleItemListView.routeName:
                            return const SampleItemListView();
                          default:
                            return const SplashPage();
                            //return const LoginPage();
                        }
                    //   case AuthenticationStatus.unauthenticated:
                    //     return const LoginPage();
                    //   case AuthenticationStatus.unknown:
                    //     return const SplashPage();
                    //   default:
                    //     return const LoginPage();
                    // }
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
