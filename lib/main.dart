import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/config/theme/themes.dart';
import 'package:flutter_news_app/core/constants/app_constants.dart';
import 'package:flutter_news_app/core/constants/cache_constants.dart';
import 'package:flutter_news_app/core/service/cache/cache_service.dart';
import 'package:flutter_news_app/core/service/routes/app_pages.dart';
import 'package:flutter_news_app/core/service/theme/theme_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  await _init();
  runApp(MyApp());
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init(CacheConstants.storageName);
  Get.put(CacheService());
  Get.put(ThemeService()).init();
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final themeService = Get.find<ThemeService>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppConstants.appName,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeService.themeMode,
          getPages: AppPages.routes,
          initialRoute: AppPages.initial,
        );
      },
    );
  }
}
