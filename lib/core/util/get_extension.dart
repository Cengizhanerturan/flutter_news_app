import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/model/news_model.dart';
import 'package:flutter_news_app/view/auth/pages/verify_mail/verifiy_mail_page_binding.dart';
import 'package:flutter_news_app/view/auth/pages/verify_mail/verify_mail_page.dart';
import 'package:flutter_news_app/view/details/details_page.dart';
import 'package:flutter_news_app/view/details/details_page_binding.dart';
import 'package:flutter_news_app/view/webview/webview_page.dart';
import 'package:flutter_news_app/view/webview/webview_page_binding.dart';
import 'package:get/get.dart';

extension CustomGetExtension on GetInterface {
  Future<void> toDetailsPage({
    required NewsModel newsModel,
    bool isFromSavedPage = false,
  }) async {
    var controllerTag = UniqueKey().toString();
    await Get.to(
      () => DetailsPage(controllerTag: controllerTag),
      binding: DetailsPageBinding(
        controllerTag: controllerTag,
        newsModel: newsModel,
        isFromSavedPage: isFromSavedPage,
      ),
      routeName: '/details',
    );
  }

  Future<void> toVerifyPageFromUpdateMailPage(String newEmail) async {
    await Get.offAll(
      () => VerifyMailPage(isFromAuthPage: false),
      binding: VerifiyMailPageBinding(
        isFromUpdateMailPage: true,
        newEmail: newEmail,
      ),
      routeName: '/verifyMail',
    );
  }

  Future<void> toWebViewPage({required String url}) async {
    await Get.to(
      () => WebviewPage(),
      binding: WebviewPageBinding(url: url),
      routeName: '/webview',
    );
  }
}
