import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/service/routes/app_routes.dart';
import 'package:flutter_news_app/view/setting/setting_page_controller.dart';
import 'package:flutter_news_app/widget/custom_dialog.dart';
import 'package:flutter_news_app/widget/setting_card.dart';
import 'package:flutter_news_app/widget/title_widget.dart';
import 'package:get/get.dart';

class SettingPage extends GetView<SettingPageController> {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(
                title: StringConstants.SETTINGS_PAGE_TITLE,
                subtitle: StringConstants.SETTINGS_PAGE_SUBTITLE,
              ),
              Obx(
                () => SettingCard(
                  title: StringConstants.DARK_MODE_TITLE,
                  subtitle: StringConstants.DARK_MODE_SUBTITLE,
                  isSwitch: true,
                  switchValue: controller.isDarkMode.value,
                  switchOnChanged: (value) async {
                    await controller.toggleTheme(value);
                  },
                ),
              ),
              SettingCard(
                title: StringConstants.UPDATE_USER_INFORMATION_PAGE_TITLE,
                subtitle: StringConstants.UPDATE_USER_INFORMATION_PAGE_SUBTITLE,
                onTap: () async {
                  await Get.toNamed(Routes.UPDATE_USER_INFORMATION);
                },
              ),
              SettingCard(
                title: StringConstants.UPDATE_MAIL_PAGE_TITLE,
                subtitle: StringConstants.UPDATE_MAIL_PAGE_SUBTITLE,
                onTap: () async {
                  await Get.toNamed(Routes.UPDATE_MAIL);
                },
              ),
              SettingCard(
                title: StringConstants.UPDATE_PASSWORD_PAGE_TITLE,
                subtitle: StringConstants.UPDATE_PASSWORD_PAGE_SUBTITLE,
                onTap: () async {
                  await Get.toNamed(Routes.UPDATE_PASSWORD);
                },
              ),
              SettingCard(
                title: StringConstants.LOGOUT_TITLE,
                subtitle: StringConstants.LOGOUT_SUBTITLE,
                icon: Icons.logout_rounded,
                onTap: () async {
                  await Get.dialog(
                    CustomDialog(
                      message: StringConstants.LOGOUT_DIALOG_MESSAGE,
                      primaryButtonText:
                          StringConstants.DIALOG_LOGOUT_BUTTON_TEXT,
                      secondaryButtonText:
                          StringConstants.DIALOG_CANCEL_BUTTON_TEXT,
                      primaryButtonOnTap: () async {
                        await controller.logout();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
