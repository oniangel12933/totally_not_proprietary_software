import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:insidersapp/src/pages/login/enter_otp_page/enter_otp_page.dart';
import 'package:insidersapp/src/pages/login/get_started/getting_started_page.dart';
import 'package:insidersapp/src/pages/login/login_page/login_page.dart';
import 'package:insidersapp/src/pages/login/sign_up_page/sign_up_page.dart';
import 'package:insidersapp/src/pages/sample_feature/sample_item_details_view.dart';
import 'package:insidersapp/src/pages/sample_feature/sample_item_list_view.dart';
import 'package:insidersapp/src/pages/settings/settings_controller.dart';
import 'package:insidersapp/src/pages/settings/settings_page.dart';
import 'package:insidersapp/src/pages/splash/splash_page.dart';
import 'package:insidersapp/src/repositories/auth/auth_repository.dart';
import 'package:insidersapp/src/repositories/secure_storage/secure_repository.dart';
import 'package:insidersapp/src/repositories/user/user_repository.dart';
import 'package:insidersapp/src/shared/blocs/auth_bloc/auth_bloc.dart';
import 'package:insidersapp/src/shared/blocs/auth_bloc/auth_state.dart';
import 'package:insidersapp/src/theme/app_theme.dart';
import 'package:insidersapp/src/theme/colors.dart';
import 'package:insidersapp/src/theme/theme_cubit.dart';

import 'package:insidersapp/src/router/router.gr.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
    required this.authenticationRepository,
    required this.userRepository,
    required this.secureRepository,
  }) : super(key: key);

  final SettingsController settingsController;
  final AuthRepository authenticationRepository;
  final UserRepository userRepository;
  final SecureStorageRepository secureRepository;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: widget.authenticationRepository),
        RepositoryProvider.value(value: widget.userRepository),
        RepositoryProvider.value(value: widget.secureRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (BuildContext context) {
              return AuthBloc(
                authenticationRepository: widget.authenticationRepository,
                userRepository: widget.userRepository,
                secureRepository: widget.secureRepository,
              )..setAppStarted();
            },
          ),
          BlocProvider<ThemeCubit>(
            create: (BuildContext context) => ThemeCubit(),
          ),
        ],
        child: AppView(
            settingsController: widget.settingsController,
            navigatorKey: _navigatorKey),
      ),
    );
  }

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
}

class AppView extends StatefulWidget {
  const AppView({
    Key? key,
    required this.settingsController,
    required this.navigatorKey,
  }) : super(key: key);

  final SettingsController settingsController;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _appRouter = AppRouter(
      // authGuard: AuthGuard(),
      );

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (BuildContext context, ThemeState themeState) {
        // The AnimatedBuilder Widget listens to the SettingsController for changes.
        // Whenever the user updates their settings, the MaterialApp is rebuilt.
        return AnimatedBuilder(
          animation: widget.settingsController,
          builder: (BuildContext context, Widget? child) {
            return MaterialApp.router(
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
              theme: AppThemes.lightTheme,
              darkTheme: AppThemes.darkTheme.copyWith(
                colorScheme: AppThemes.darkTheme.colorScheme
                    .copyWith(secondary: AppColors.accent),
              ),
              themeMode: themeState.themeMode,

              routerDelegate: _appRouter.delegate(),
              routeInformationProvider: _appRouter.routeInfoProvider(),
              routeInformationParser: _appRouter.defaultRouteParser(),

              builder: (context, router) {
                return BlocListener<AuthBloc, AuthState>(
                  listener: (context, AuthState state) {
                    if (state is AuthUninitialized) {
                      // We are loading something, show spinner since it can take some time
                      _appRouter.replace(const SplashRoute());
                    } else if (state is AuthLoggingOut) {
                      // We are logging out (may take a second or two, show loading screen)
                      _appRouter.replace(const SplashRoute());
                    } else if (state is AuthLoggedOut) {
                      // We are logged out
                      _appRouter.replaceAll([const GetStartedRoute()]);
                    } else if (state is AuthUnauthenticated) {
                      // User is not authenticated, show the splash/start screen
                      _appRouter.replaceAll([const GetStartedRoute()]);
                    } else if (state is AuthAuthenticated) {
                      // HomePage
                      _appRouter.replaceAll([const SampleItemListRoute()]);
                    }

                    // state.when(
                    //   authUnauthenticated: () =>
                    //       _appRouter.replace(const GetStartedPageRoute()),
                    //   authAuthenticated: () =>
                    //       _appRouter.replace(const HomePageRoute()),
                    //   authLoggingOut: () =>
                    //       _appRouter.replace(const SplashPageRoute()),
                    //   authUninitialized: () =>
                    //       _appRouter.replace(const SplashPageRoute()),
                    //   authLoading: () =>
                    //       _appRouter.replace(const SplashPageRoute()),
                    //   authLoggedOut: () =>
                    //       _appRouter.replace(const GetStartedPageRoute()),
                    // );
                  },
                  child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                    return router ?? Container();
                  }),
                );
              },
            );
          },
        );
      },
    );
  }
}
