import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/enums.dart';
import 'package:flutter_news_app/core/model/news_model.dart';
import 'package:flutter_news_app/core/service/repository/news_repository_impl.dart';
import 'package:flutter_news_app/core/util/extensions.dart';
import 'package:get/get.dart';

class DiscoverPageController extends GetxController
    with GetSingleTickerProviderStateMixin, StateMixin {
  final _newsRepository = Get.find<NewsRepositoryImpl>();
  late final TabController tabController;
  late final PageController pageController;

  var currentIndex = 0.obs;

  var newsMap = <NEWS_CATEGORY, List<NewsModel>>{}.obs;

  var tabTitleList = NEWS_CATEGORY.values.map((e) => e.name).toList();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      length: NEWS_CATEGORY.values.length,
      vsync: this,
    );
    pageController = PageController(
      initialPage: currentIndex.value,
      keepPage: true,
    );
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      change(null, status: RxStatus.loading());
      for (var category in NEWS_CATEGORY.values) {
        var news = await _newsRepository.getTopHeadlines(
          category: category == NEWS_CATEGORY.ALL ? null : category.apiName,
        );
        newsMap[category] = news;
      }
      change(null, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  List<NewsModel> currentNewsList(int index) {
    return newsMap[NEWS_CATEGORY.values[index]] ?? [];
  }

  void clearTabbar() {
    tabController.index = 0;
    currentIndex.value = 0;
  }
}
