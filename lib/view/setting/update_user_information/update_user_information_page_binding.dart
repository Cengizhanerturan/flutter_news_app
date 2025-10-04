import 'package:flutter_news_app/view/setting/update_user_information/update_user_information_page_controller.dart';
import 'package:get/get.dart';

class UpdateUserInformationPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UpdateUserInformationPageController());
  }
}
