import 'package:flutter_news_app/view/splash/splash_page_controller.dart';
import 'package:get/get.dart';

class SplashPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashPageController());
  }
}
