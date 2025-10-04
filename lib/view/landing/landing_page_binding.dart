import 'package:flutter_news_app/view/landing/landing_page_controller.dart';
import 'package:get/get.dart';

class LandingPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LandingPageController());
  }
}
