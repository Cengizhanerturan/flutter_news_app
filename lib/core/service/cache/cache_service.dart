import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/cache_constants.dart';
import 'package:flutter_news_app/core/model/news_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CacheService extends GetxService {
  final _storage = GetStorage(CacheConstants.storageName);

  Future<bool> saveNews(NewsModel news) async {
    try {
      var data = getSavedNewsList();
      if (data.isEmpty) {
        return await _setStorage(
          key: CacheConstants.keySavedNews,
          value: [news.toMap()],
        );
      } else {
        data.add(news);
        return await _setStorage(
          key: CacheConstants.keySavedNews,
          value: data.map((news) => news.toMap()).toList(),
        );
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeNews(NewsModel news) async {
    try {
      var data = getSavedNewsList();
      var isDeleted = data.remove(news);
      if (isDeleted) {
        return await _setStorage(
          key: CacheConstants.keySavedNews,
          value: data.map((news) => news.toMap()).toList(),
        );
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  bool getIsSaved(NewsModel newsModel) {
    try {
      var data = _getStorage(key: CacheConstants.keySavedNews);
      if (data == null) {
        return false;
      } else {
        var savedNewsList = List<NewsModel>.from(
          data.map((news) => NewsModel.fromMap(news)),
        );
        return savedNewsList.contains(newsModel);
      }
    } catch (e) {
      return false;
    }
  }

  List<NewsModel> getSavedNewsList() {
    try {
      var savedNewsList = _getStorage(key: CacheConstants.keySavedNews);
      if (savedNewsList == null) {
        return [];
      } else {
        return List<NewsModel>.from(
          savedNewsList.map((news) => NewsModel.fromMap(news)),
        );
      }
    } catch (e) {
      return [];
    }
  }

  ThemeMode getTheme() {
    try {
      var isDarkMode = _getStorage(key: CacheConstants.keyIsDarkMode);
      if (isDarkMode == null) {
        return ThemeMode.light;
      } else {
        return isDarkMode ? ThemeMode.dark : ThemeMode.light;
      }
    } catch (e) {
      return ThemeMode.light;
    }
  }

  Future<bool> setTheme(ThemeMode themeMode) async {
    try {
      return await _setStorage(
        key: CacheConstants.keyIsDarkMode,
        value: themeMode == ThemeMode.dark,
      );
    } catch (e) {
      return false;
    }
  }

  dynamic _getStorage({required String key}) {
    try {
      if (_storage.hasData(key)) {
        return _storage.read(key);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> _setStorage({
    required String key,
    required dynamic value,
  }) async {
    try {
      await _storage.write(key, value);
      return true;
    } catch (e) {
      return false;
    }
  }
}
