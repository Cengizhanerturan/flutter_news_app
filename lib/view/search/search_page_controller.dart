import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/model/news_model.dart';
import 'package:flutter_news_app/core/service/repository/news_repository_impl.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController with StateMixin {
  final _newsRepository = Get.find<NewsRepositoryImpl>();
  final textEditingController = TextEditingController();

  final _initNewsList = <NewsModel>[].obs;
  var newsList = <NewsModel>[].obs;

  final _searchString = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _initNews();
    _initSearchListener();
  }

  void onTextChanged(String value) {
    _searchString.value = value;
  }

  void _initSearchListener() {
    debounce(_searchString, (value) async {
      if (value.isNotEmpty) {
        await _searchNews(value);
      } else {
        await _initNews();
      }
    }, time: const Duration(milliseconds: 500));
  }

  Future<void> _searchNews(String searchString) async {
    try {
      change(null, status: RxStatus.loading());
      newsList.value = await _newsRepository.getSearchNews(
        searchString: searchString,
      );
      change(null, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> _initNews() async {
    try {
      change(null, status: RxStatus.loading());
      if (_initNewsList.isNotEmpty) {
        newsList.assignAll(_initNewsList);
      } else {
        newsList.value = await _newsRepository.getTopHeadlines();
        _initNewsList.assignAll(newsList);
      }

      change(null, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> onRetry() async {
    await _initNews();
  }
}
