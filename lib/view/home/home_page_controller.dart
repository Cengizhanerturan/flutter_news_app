import 'package:flutter_news_app/core/model/news_model.dart';
import 'package:flutter_news_app/core/service/remote/user_service.dart';
import 'package:flutter_news_app/core/service/repository/news_repository_impl.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController with StateMixin {
  final _userService = Get.find<UserService>();
  final _newsRepository = Get.find<NewsRepositoryImpl>();

  final sliderCurrentPage = 0.obs;

  var newsList = <NewsModel>[].obs;
  var sliderNewsList = <NewsModel>[].obs;

  String get userInformation {
    if (_userService.user != null) {
      var user = _userService.user;
      var name = user!.name;
      var surname = user.surname;
      return '$name $surname';
    }
    return '';
  }

  @override
  void onInit() {
    super.onInit();
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      change(null, status: RxStatus.loading());
      var data = await _newsRepository.getTopHeadlines();
      if (data.isNotEmpty) {
        sliderNewsList.value = data.sublist(0, 5);
        newsList.value = data.sublist(5);
        change(newsList, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
