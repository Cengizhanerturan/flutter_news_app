import 'package:flutter_news_app/core/model/news_model.dart';
import 'package:flutter_news_app/core/model/news_response_model.dart';
import 'package:flutter_news_app/core/service/remote/news_api_service.dart';
import 'package:flutter_news_app/core/service/repository/news_repository.dart';
import 'package:flutter_news_app/core/util/helper.dart';
import 'package:get/get.dart';

class NewsRepositoryImpl extends NewsRepository {
  final _newsApiService = Get.find<NewsApiService>();

  @override
  Future<List<NewsModel>> getTopHeadlines({
    String? category,
    int? pageSize,
  }) async {
    try {
      var response = await _newsApiService.getTopHeadlines(
        category: category,
        pageSize: pageSize,
      );
      return Helper.handleResponse(response, NewsResponseModel.decoder);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<NewsModel>> getSearchNews({required String searchString}) async {
    try {
      var response = await _newsApiService.getSearchNews(
        searchString: searchString,
      );
      return Helper.handleResponse(response, NewsResponseModel.decoder);
    } catch (e) {
      rethrow;
    }
  }
}
