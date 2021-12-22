import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get_it/get_it.dart';

import 'package:involio/src/router/router.gr.dart';
import 'package:involio/src/shared/blocs/auth_bloc/auth_bloc.dart';
import 'package:involio/src/shared/blocs/auth_bloc/auth_state.dart';
import 'package:involio/src/theme/app_theme.dart';
import 'package:involio/src/theme/colors.dart';
import 'package:involio/src/theme/theme_cubit.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = GetIt.I.get<AuthBloc>();
    return MultiBlocProvider(
      providers: [
        /// AuthBloc uses a value provider so that it does get closed by
        /// the provider, the close will happen in get_it.
        BlocProvider<AuthBloc>.value(
          value: authBloc..setAppStarted(),
        ),
        BlocProvider<ThemeCubit>(
          create: (BuildContext context) => ThemeCubit(),
        ),
      ],
      child: PlatformProvider(
        settings: PlatformSettingsData(
          platformStyle: const PlatformStyleData(
            web: PlatformStyle.Cupertino,
            //android: PlatformStyle.Cupertino,
            //ios: PlatformStyle.Material,
          ),
          iosUsesMaterialWidgets: true,
        ),
        builder: (BuildContext context) => const AppView(
            //navigatorKey: _navigatorKey,
            ),
      ),
    );
  }

//final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
}

class AppView extends StatefulWidget {
  const AppView({
    Key? key,
    //required this.navigatorKey,
  }) : super(key: key);

  //final GlobalKey<NavigatorState> navigatorKey;

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
        return MaterialApp.router(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
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

          theme: AppThemes.materialLightTheme,
          darkTheme: AppThemes.materialDarkTheme.copyWith(
            colorScheme: AppThemes.materialDarkTheme.colorScheme
                .copyWith(secondary: AppColors.involioBrightBlue),
          ),
          themeMode: themeState.getMaterialThemeMode(),

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
                  //_appRouter.replaceAll([const SampleItemListRoute()]);
                  _appRouter.replaceAll([const MainRoute()]);
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
                },
              ),
            );
          },
        );
      },
    );
  }
}
