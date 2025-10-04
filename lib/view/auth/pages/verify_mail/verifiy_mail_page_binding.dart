import 'package:flutter_news_app/view/auth/pages/verify_mail/verify_mail_page_controller.dart';
import 'package:get/get.dart';

class VerifiyMailPageBinding extends Bindings {
  final bool isFromUpdateMailPage;
  final String? newEmail;
  VerifiyMailPageBinding({this.isFromUpdateMailPage = false, this.newEmail});

  @override
  void dependencies() {
    Get.put(
      VerifyMailPageController(
        isFromAuthPage: false,
        isFromUpdateMailPage: isFromUpdateMailPage,
        newEmail: newEmail,
      ),
    );
  }
}
