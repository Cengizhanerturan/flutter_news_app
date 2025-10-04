import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_news_app/core/service/cache/cache_service.dart';
import 'package:get/get.dart';

class ThemeService extends GetxService {
  late ThemeMode themeMode;

  final _cacheService = Get.find<CacheService>();

  void init() {
    getTheme();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  void getTheme() {
    themeMode = _cacheService.getTheme();
    _setSystemUIOverlayStyle();
  }

  void _setSystemUIOverlayStyle() {
    if (themeMode == ThemeMode.light) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      );
    }
  }

  Future<void> toggleTheme() async {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    _setSystemUIOverlayStyle();
    Get.changeThemeMode(themeMode);
    await _cacheService.setTheme(themeMode);
  }
}
