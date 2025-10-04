import 'package:dio/dio.dart' as dio;
import 'package:flutter_news_app/core/constants/api_constants.dart';
import 'package:get/get.dart';

class NewsApiService extends GetxService {
  late final dio.Dio _dio;

  void init() {
    _dio = dio.Dio(dio.BaseOptions(baseUrl: ApiConstants.BASE_URL));
  }

  Future<dio.Response> getTopHeadlines({
    String? category,
    int? pageSize,
  }) async {
    try {
      var param = {
        'country': ApiConstants.DEFAULT_COUNTRY,
        'pageSize': pageSize ?? ApiConstants.DEFAULT_PAGE_SIZE,
        'apiKey': ApiConstants.API_KEY,
      };

      if (category != null) {
        param['category'] = category;
      }

      var response = await _dio.get('top-headlines', queryParameters: param);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dio.Response> getSearchNews({required String searchString}) async {
    try {
      return _dio.get(
        'everything',
        queryParameters: {'q': searchString, 'apiKey': ApiConstants.API_KEY},
      );
    } catch (e) {
      rethrow;
    }
  }
}
