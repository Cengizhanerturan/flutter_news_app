import 'package:flutter_news_app/core/model/news_model.dart';
import 'package:flutter_news_app/view/details/details_page_controller.dart';
import 'package:get/get.dart';

class DetailsPageBinding extends Bindings {
  final String controllerTag;
  final NewsModel newsModel;
  final bool isFromSavedPage;

  DetailsPageBinding({
    required this.controllerTag,
    required this.newsModel,
    required this.isFromSavedPage,
  });

  @override
  void dependencies() {
    Get.put(
      DetailsPageController(
        newsModel: newsModel,
        isFromSavedPage: isFromSavedPage,
      ),
      tag: controllerTag,
    );
  }
}
