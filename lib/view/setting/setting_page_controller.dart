import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/service/repository/user_repository_impl.dart';
import 'package:flutter_news_app/core/service/routes/app_routes.dart';
import 'package:flutter_news_app/core/service/theme/theme_service.dart';
import 'package:flutter_news_app/core/util/helper.dart';
import 'package:flutter_news_app/widget/custom_dialog.dart';
import 'package:get/get.dart';

class SettingPageController extends GetxController {
  final _userRepository = Get.find<UserRepositoryImpl>();
  final ThemeService _themeService = Get.find<ThemeService>();

  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (_themeService.themeMode == ThemeMode.light) {
      isDarkMode.value = false;
    } else {
      isDarkMode.value = true;
    }
  }

  Future<void> toggleTheme(bool value) async {
    isDarkMode.value = value;
    await _themeService.toggleTheme();
  }

  Future<void> logout() async {
    try {
      await _userRepository.logout();
      await Get.offAllNamed(Routes.AUTH);
    } catch (e) {
      final message = Helper.handleAuthErrorMessage(e);
      await Get.dialog(CustomDialog(message: message));
    }
  }
}
