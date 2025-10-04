import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_news_app/core/service/remote/news_api_service.dart';
import 'package:flutter_news_app/core/service/repository/news_repository_impl.dart';
import 'package:flutter_news_app/core/service/routes/app_routes.dart';
import 'package:flutter_news_app/view/discover/discover_page_binding.dart';
import 'package:flutter_news_app/view/discover/discover_page.dart';
import 'package:flutter_news_app/view/home/home_page_binding.dart';
import 'package:flutter_news_app/view/home/home_page.dart';
import 'package:flutter_news_app/view/saved/saved_page_binding.dart';
import 'package:flutter_news_app/view/saved/saved_page.dart';
import 'package:flutter_news_app/view/setting/setting_page_binding.dart';
import 'package:flutter_news_app/view/setting/setting_page.dart';
import 'package:get/get.dart';

class LandingPageController extends GetxController {
  var currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _initServices();
  }

  void _initServices() {
    Get.put(NewsApiService()).init();
    Get.put(NewsRepositoryImpl());
  }

  Future<void> changePage(int index) async {
    if (currentIndex.value != index) {
      currentIndex.value = index;
      Get.toNamed(_routes[index], id: 1, preventDuplicates: false);
    }
  }

  final _routes = [Routes.HOME, Routes.DISCOVER, Routes.SAVED, Routes.SETTING];

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.HOME:
        return GetPageRoute(
          settings: settings,
          page: () => HomePage(),
          binding: HomePageBinding(),
          transition: Transition.fadeIn,
        );
      case Routes.DISCOVER:
        return GetPageRoute(
          settings: settings,
          page: () => DiscoverPage(),
          binding: DiscoverPageBinding(),
          transition: Transition.fadeIn,
        );
      case Routes.SAVED:
        return GetPageRoute(
          settings: settings,
          page: () => SavedPage(),
          binding: SavedPageBinding(),
          transition: Transition.fadeIn,
        );
      case Routes.SETTING:
        return GetPageRoute(
          settings: settings,
          page: () => SettingPage(),
          binding: SettingPageBinding(),
          transition: Transition.fadeIn,
        );
      default:
        return GetPageRoute(
          settings: settings,
          page: () => HomePage(),
          binding: HomePageBinding(),
          transition: Transition.fadeIn,
        );
    }
  }

  void onPopInvokedWithResult(bool didPop, dynamic result) {
    if (currentIndex.value != 0) {
      changePage(0);
    } else {
      SystemNavigator.pop();
    }
  }
}
