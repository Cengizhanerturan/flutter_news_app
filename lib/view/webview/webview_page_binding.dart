import 'package:flutter_news_app/view/webview/webview_page_controller.dart';
import 'package:get/get.dart';

class WebviewPageBinding extends Bindings {
  final String url;
  WebviewPageBinding({required this.url});
  @override
  void dependencies() {
    Get.put(WebviewPageController(url: url));
  }
}
