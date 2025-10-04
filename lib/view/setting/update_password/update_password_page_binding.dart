import 'package:flutter_news_app/view/setting/update_password/update_password_page_controller.dart';
import 'package:get/get.dart';

class UpdatePasswordPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UpdatePasswordPageController());
  }
}
