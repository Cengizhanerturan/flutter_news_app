import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/asset_constants.dart';
import 'package:flutter_news_app/view/splash/splash_page_controller.dart';
import 'package:flutter_news_app/widget/loading_widget.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashPage extends GetView<SplashPageController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(),
            Image.asset(
              AssetConstants.appIconPrimary,
              width: 160.px,
              height: 160.px,
            ),
            LoadingWidget(),
          ],
        ),
      ),
    );
  }
}
