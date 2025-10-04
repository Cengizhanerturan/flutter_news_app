import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/enums.dart';
import 'package:flutter_news_app/view/auth/pages/mail/mail_page.dart';
import 'package:flutter_news_app/view/auth/pages/password/password_page.dart';
import 'package:flutter_news_app/view/auth/pages/registration_details/registration_details_page.dart';
import 'package:flutter_news_app/view/auth/pages/verify_mail/verify_mail_page.dart';
import 'package:get/get.dart';

class AuthPageController extends GetxController {
  final pageController = PageController();

  final authType = AUTH_TYPE.REGISTER.obs;

  final mail = ''.obs;
  final password = ''.obs;
  final repassword = ''.obs;
  final name = ''.obs;
  final surname = ''.obs;

  final _pages = <Widget>[
    const MailPage(),
    const PasswordPage(),
    const VerifyMailPage(),
    const RegistrationDetailsPage(),
  ];

  final _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;

  Widget currentPage(int index) {
    return _pages[index];
  }

  int get pageCount => _pages.length;

  void onPageChanged(int index) {
    _currentIndex.value = index;
  }

  Future<void> goToPage() async {
    await pageController.animateToPage(
      _currentIndex.value + 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  Future<void> backToPage() async {
    await pageController.animateToPage(
      _currentIndex.value - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }
}
