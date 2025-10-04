import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/model/states/state.dart';
import 'package:flutter_news_app/core/util/validator.dart';
import 'package:flutter_news_app/view/setting/update_mail/update_mail_page_controller.dart';
import 'package:flutter_news_app/widget/custom_back_button.dart';
import 'package:flutter_news_app/widget/custom_button.dart';
import 'package:flutter_news_app/widget/custom_text_form_field.dart';
import 'package:flutter_news_app/widget/title_widget.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UpdateMailPage extends GetView<UpdateMailPageController> {
  const UpdateMailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBackButton(
                  padding: EdgeInsets.only(
                    left: 16.px,
                    right: 16.px,
                    top: 16.px,
                  ),
                ),
                TitleWidget(
                  title: StringConstants.UPDATE_MAIL_PAGE_TITLE,
                  subtitle: StringConstants.UPDATE_MAIL_PAGE_SUBTITLE,
                ),
                CustomTextFormField(
                  controller: controller.currentEmailTextEditingController,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.px,
                    vertical: 16.px,
                  ),
                  enabled: false,
                ),
                CustomTextFormField(
                  controller: controller.emailTextEditingController,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.px,
                    vertical: 16.px,
                  ),
                  hintText: StringConstants.MAIL_TEXT_FIELD_HINT,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => Validator.validateEmail(value),
                  onChanged: (value) => controller.email = value,
                ),
                CustomTextFormField(
                  controller: controller.passwordTextEditingController,
                  isPassword: true,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.px,
                    vertical: 16.px,
                  ),
                  hintText: StringConstants.PASSWORD_TEXT_FIELD_HINT,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) => Validator.validatePassword(value),
                  onChanged: (value) => controller.password = value,
                ),
                Obx(
                  () => CustomButton(
                    buttonText: StringConstants.CONTINUE_BUTTON_TEXT,
                    onTap: () async {
                      await controller.onTap(context);
                    },
                    isEnabled: controller.isButtonEnabled,
                    isLoading: controller.state is Loading,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
