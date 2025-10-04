import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/model/states/auth_state.dart';
import 'package:flutter_news_app/view/auth/pages/verify_mail/verify_mail_page_controller.dart';
import 'package:flutter_news_app/widget/custom_back_button.dart';
import 'package:flutter_news_app/widget/custom_button.dart';
import 'package:flutter_news_app/widget/title_widget.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VerifyMailPage extends GetView<VerifyMailPageController> {
  final bool isFromAuthPage;
  const VerifyMailPage({super.key, this.isFromAuthPage = true});

  @override
  Widget build(BuildContext context) {
    if (isFromAuthPage) {
      return GetBuilder(
        init: Get.put(VerifyMailPageController()),
        builder: (_) {
          return _buildBody(context);
        },
      );
    } else {
      return Scaffold(body: SafeArea(child: _buildBody(context)));
    }
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isFromAuthPage)
          CustomBackButton(
            padding: EdgeInsets.only(left: 16.px, right: 16.px, top: 16.px),
            onTap: () => controller.backToPage(),
          ),
        TitleWidget(
          title: StringConstants.VERIFY_MAIL_PAGE_TITLE,
          subtitle: StringConstants.VERIFY_MAIL_PAGE_SUBTITLE,
        ),
        Obx(
          () => CustomButton(
            buttonText: StringConstants.CONTINUE_BUTTON_TEXT,
            onTap: () {
              controller.onTap(context);
            },
            isLoading: controller.state is AuthStateLoading,
          ),
        ),
      ],
    );
  }
}
