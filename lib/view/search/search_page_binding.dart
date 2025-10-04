import 'package:flutter_news_app/view/search/search_page_controller.dart';
import 'package:get/get.dart';

class SearchPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchPageController());
  }
}
