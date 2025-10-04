import 'package:flutter_news_app/view/home/home_page_controller.dart';
import 'package:get/get.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomePageController(), permanent: true);
  }
}
