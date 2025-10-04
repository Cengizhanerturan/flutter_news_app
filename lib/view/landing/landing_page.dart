import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/app_constants.dart';
import 'package:flutter_news_app/core/service/routes/app_routes.dart';
import 'package:flutter_news_app/view/landing/landing_page_controller.dart';
import 'package:get/get.dart';

class LandingPage extends GetView<LandingPageController> {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: controller.onPopInvokedWithResult,
      child: Scaffold(
        body: Navigator(
          key: Get.nestedKey(1),
          initialRoute: Routes.HOME,
          onGenerateRoute: controller.onGenerateRoute,
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changePage,
            items: _createBottomNavItems(),
          ),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _createBottomNavItems() {
    return List.generate(AppConstants.bottomNavLabels.length, (index) {
      return BottomNavigationBarItem(
        icon: Image.asset(
          controller.currentIndex.value == index
              ? AppConstants.bottomNavActiveIcons[index]
              : AppConstants.bottomNavIcons[index],
          width: 24,
          height: 24,
          color:
              controller.currentIndex.value == index
                  ? Get.theme.bottomNavigationBarTheme.selectedItemColor
                  : Get.theme.bottomNavigationBarTheme.unselectedItemColor,
        ),
        label: AppConstants.bottomNavLabels[index],
      );
    });
  }
}
