import 'package:flutter_news_app/core/model/news_model.dart';
import 'package:flutter_news_app/core/service/cache/cache_service.dart';
import 'package:get/get.dart';

class SavedPageController extends GetxController with StateMixin {
  final _cacheService = Get.find<CacheService>();

  var list = <NewsModel>[].obs;

  Future<void> getSavedNews() async {
    try {
      change(null, status: RxStatus.loading());
      list.value = _cacheService.getSavedNewsList();
      if (list.isEmpty) {
        change(null, status: RxStatus.empty());
      } else {
        change(list, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }
}
