import 'package:flutter_news_app/core/model/news_model.dart';
import 'package:flutter_news_app/core/service/cache/cache_service.dart';
import 'package:flutter_news_app/core/util/get_extension.dart';
import 'package:flutter_news_app/view/saved/saved_page_controller.dart';
import 'package:get/get.dart';

class DetailsPageController extends GetxController {
  final NewsModel newsModel;
  final bool isFromSavedPage;
  DetailsPageController({
    required this.newsModel,
    required this.isFromSavedPage,
  });

  final _cacheService = Get.find<CacheService>();

  var isSaved = false.obs;

  @override
  void onInit() {
    super.onInit();
    _getIsSaved();
  }

  Future<void> toogleSaveButton() async {
    if (isSaved.value) {
      await _removeNews();
      if (isFromSavedPage && Get.isRegistered<SavedPageController>()) {
        var savedPageController = Get.find<SavedPageController>();
        savedPageController
          ..list.remove(newsModel)
          ..update();
      }
    } else {
      await _saveNews();
    }
  }

  void _getIsSaved() {
    try {
      isSaved.value = _cacheService.getIsSaved(newsModel);
    } catch (e) {
      isSaved.value = false;
    }
  }

  Future<void> _removeNews() async {
    try {
      var isRemoved = await _cacheService.removeNews(newsModel);
      if (isRemoved) {
        isSaved.value = false;
      } else {
        isSaved.value = true;
      }
    } catch (e) {
      isSaved.value = true;
    }
  }

  Future<void> _saveNews() async {
    try {
      var isSaved = await _cacheService.saveNews(newsModel);
      if (isSaved) {
        this.isSaved.value = true;
      } else {
        this.isSaved.value = false;
      }
    } catch (e) {
      isSaved.value = false;
    }
  }

  Future<void> openNewsInWebview() async {
    await Get.toWebViewPage(url: newsModel.url);
  }
}
