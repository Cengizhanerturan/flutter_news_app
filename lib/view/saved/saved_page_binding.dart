import 'package:flutter_news_app/view/saved/saved_page_controller.dart';
import 'package:get/get.dart';

class SavedPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SavedPageController());
  }
}
