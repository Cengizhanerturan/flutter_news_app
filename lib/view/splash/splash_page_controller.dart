import 'package:flutter_news_app/core/service/remote/auth_service.dart';
import 'package:flutter_news_app/core/service/remote/firestore_service.dart';
import 'package:flutter_news_app/core/service/remote/user_service.dart';
import 'package:flutter_news_app/core/service/repository/user_repository_impl.dart';
import 'package:flutter_news_app/core/service/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashPageController extends GetxController {
  late final UserRepositoryImpl _userRepository;

  @override
  Future<void> onInit() async {
    super.onInit();
    await init();
  }

  Future<void> init() async {
    initServices();
    await checkRoutes();
  }

  void initServices() {
    Get.put(AuthService());
    Get.put(FirestoreService());
    Get.put(UserService());
    _userRepository = Get.put(UserRepositoryImpl());
  }

  Future<void> checkRoutes() async {
    await Future.delayed(const Duration(seconds: 2));
    final isUserAvailable = await _userRepository.isUserAvailable();
    if (isUserAvailable) {
      final getUser = await _userRepository.initUser();
      if (getUser) {
        final isEmailVerified = await _userRepository.checkEmailVerification();
        if (isEmailVerified) {
          await Get.offAndToNamed(Routes.LANDING);
        } else {
          await Get.offAndToNamed(Routes.VERIFY_MAIL);
        }
      } else {
        await Get.offAndToNamed(Routes.AUTH);
      }
    } else {
      await Get.offAndToNamed(Routes.AUTH);
    }
  }
}
