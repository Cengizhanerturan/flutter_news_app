import 'package:flutter_news_app/view/auth/auth_page_controller.dart';
import 'package:get/get.dart';

class AuthPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthPageController());
  }
}
