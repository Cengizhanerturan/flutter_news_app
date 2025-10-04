import 'package:flutter_news_app/core/service/routes/app_routes.dart';
import 'package:flutter_news_app/view/auth/auth_page.dart';
import 'package:flutter_news_app/view/auth/auth_page_binding.dart';
import 'package:flutter_news_app/view/auth/pages/verify_mail/verifiy_mail_page_binding.dart';
import 'package:flutter_news_app/view/auth/pages/verify_mail/verify_mail_page.dart';
import 'package:flutter_news_app/view/discover/discover_page_binding.dart';
import 'package:flutter_news_app/view/discover/discover_page.dart';
import 'package:flutter_news_app/view/home/home_page_binding.dart';
import 'package:flutter_news_app/view/home/home_page.dart';
import 'package:flutter_news_app/view/landing/landing_page.dart';
import 'package:flutter_news_app/view/landing/landing_page_binding.dart';
import 'package:flutter_news_app/view/saved/saved_page_binding.dart';
import 'package:flutter_news_app/view/saved/saved_page.dart';
import 'package:flutter_news_app/view/search/search_page.dart';
import 'package:flutter_news_app/view/search/search_page_binding.dart';
import 'package:flutter_news_app/view/setting/setting_page_binding.dart';
import 'package:flutter_news_app/view/setting/setting_page.dart';
import 'package:flutter_news_app/view/setting/update_mail/update_mail_page.dart';
import 'package:flutter_news_app/view/setting/update_mail/update_mail_page_binding.dart';
import 'package:flutter_news_app/view/setting/update_password/update_password_page.dart';
import 'package:flutter_news_app/view/setting/update_password/update_password_page_binding.dart';
import 'package:flutter_news_app/view/setting/update_user_information/update_user_information_page.dart';
import 'package:flutter_news_app/view/setting/update_user_information/update_user_information_page_binding.dart';
import 'package:flutter_news_app/view/splash/splash_page.dart';
import 'package:flutter_news_app/view/splash/splash_page_binding.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static String initial = Routes.INITIAL;
  static final routes = [
    GetPage(
      name: Routes.INITIAL,
      page: () => const SplashPage(),
      binding: SplashPageBinding(),
    ),
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashPage(),
      binding: SplashPageBinding(),
    ),
    GetPage(
      name: Routes.AUTH,
      page: () => const AuthPage(),
      binding: AuthPageBinding(),
    ),
    GetPage(
      name: Routes.LANDING,
      page: () => const LandingPage(),
      binding: LandingPageBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      binding: HomePageBinding(),
    ),
    GetPage(
      name: Routes.DISCOVER,
      page: () => const DiscoverPage(),
      binding: DiscoverPageBinding(),
    ),
    GetPage(
      name: Routes.SAVED,
      page: () => const SavedPage(),
      binding: SavedPageBinding(),
    ),
    GetPage(
      name: Routes.SETTING,
      page: () => SettingPage(),
      binding: SettingPageBinding(),
    ),
    GetPage(
      name: Routes.SEARCH,
      page: () => const SearchPage(),
      binding: SearchPageBinding(),
    ),
    GetPage(
      name: Routes.VERIFY_MAIL,
      page: () => const VerifyMailPage(isFromAuthPage: false),
      binding: VerifiyMailPageBinding(),
    ),
    GetPage(
      name: Routes.UPDATE_USER_INFORMATION,
      page: () => UpdateUserInformationPage(),
      binding: UpdateUserInformationPageBinding(),
    ),
    GetPage(
      name: Routes.UPDATE_MAIL,
      page: () => UpdateMailPage(),
      binding: UpdateMailPageBinding(),
    ),
    GetPage(
      name: Routes.UPDATE_PASSWORD,
      page: () => UpdatePasswordPage(),
      binding: UpdatePasswordPageBinding(),
    ),
  ];
}
