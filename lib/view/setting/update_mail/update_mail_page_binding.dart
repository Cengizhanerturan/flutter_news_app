import 'package:flutter_news_app/view/setting/update_mail/update_mail_page_controller.dart';
import 'package:get/get.dart';

class UpdateMailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UpdateMailPageController());
  }
}
