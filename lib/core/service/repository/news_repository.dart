import 'package:flutter_news_app/core/model/news_model.dart';
import 'package:get/get.dart';

abstract class NewsRepository extends GetxService {
  Future<List<NewsModel>> getTopHeadlines({String? category, int? pageSize});

  Future<List<NewsModel>> getSearchNews({required String searchString});
}
