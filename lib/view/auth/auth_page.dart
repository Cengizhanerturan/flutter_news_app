import 'package:flutter/material.dart';
import 'package:flutter_news_app/view/auth/auth_page_controller.dart';
import 'package:get/state_manager.dart';

class AuthPage extends GetView<AuthPageController> {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.pageController,
            itemCount: controller.pageCount,
            itemBuilder: (BuildContext context, int index) {
              return controller.currentPage(index);
            },
            onPageChanged: (value) => controller.onPageChanged(value),
          ),
        ),
      ),
    );
  }
}
