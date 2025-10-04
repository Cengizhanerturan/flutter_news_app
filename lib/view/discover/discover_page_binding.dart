import 'package:flutter/material.dart';
import 'package:flutter_news_app/view/discover/discover_page_controller.dart';
import 'package:get/get.dart';

class DiscoverPageBinding extends Bindings {
  @override
  void dependencies() {
    var controller = Get.put(DiscoverPageController(), permanent: true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.clearTabbar();
    });
  }
}
