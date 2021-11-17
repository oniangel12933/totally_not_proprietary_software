import 'package:auto_route/auto_route.dart';
import 'package:insidersapp/src/pages/home/home_page.dart';
import 'package:insidersapp/src/pages/login/enter_otp_page/enter_otp_page.dart';
import 'package:insidersapp/src/pages/login/get_started/getting_started_page.dart';
import 'package:insidersapp/src/pages/login/login_page/login_page.dart';
import 'package:insidersapp/src/pages/login/sign_up_page/sign_up_page.dart';
import 'package:insidersapp/src/pages/sample_feature/sample_item_list_view.dart';
import 'package:insidersapp/src/pages/settings/settings_page.dart';
import 'package:insidersapp/src/pages/splash/splash_page.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/splash',
      page: SplashPage,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
      path: '/get_started',
      page: GetStartedPage,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
      path: '/login',
      page: LoginPage,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
      path: '/signup',
      page: SignUpPage,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
      path: '/enter_otp',
      page: EnterOtpPage,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
      initial: true,
      path: '/home',
      page: HomePage,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
      initial: true,
      path: '/settings',
      page: SettingsPage,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
      initial: true,
      path: '/sample',
      page: SampleItemListPage,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),

    // redirect all other paths
    RedirectRoute(path: '*', redirectTo: '/get_started'),
    //Home
  ],
)
class $AppRouter {}

