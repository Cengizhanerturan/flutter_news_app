import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/model/states/state.dart';
import 'package:flutter_news_app/core/util/validator.dart';
import 'package:flutter_news_app/view/setting/update_password/update_password_page_controller.dart';
import 'package:flutter_news_app/widget/custom_back_button.dart';
import 'package:flutter_news_app/widget/custom_button.dart';
import 'package:flutter_news_app/widget/custom_text_form_field.dart';
import 'package:flutter_news_app/widget/title_widget.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UpdatePasswordPage extends GetView<UpdatePasswordPageController> {
  const UpdatePasswordPage({super.key});

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
                  title: StringConstants.UPDATE_PASSWORD_PAGE_TITLE,
                  subtitle: StringConstants.UPDATE_PASSWORD_PAGE_SUBTITLE,
                ),
                CustomTextFormField(
                  controller: controller.currentPasswordTextEditingController,
                  isPassword: true,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.px,
                    vertical: 16.px,
                  ),
                  hintText: StringConstants.CURRENT_PASSWORD_TEXT_FIELD_HINT,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) => Validator.validatePassword(value),
                  onChanged: (value) => controller.currentPassword = value,
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
                CustomTextFormField(
                  controller: controller.repasswordTextEditingController,
                  isPassword: true,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.px,
                    vertical: 16.px,
                  ),
                  hintText: StringConstants.REPEAT_PASSWORD_TEXT_FIELD_HINT,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) => Validator.validatePassword(value),
                  onChanged: (value) => controller.repassword = value,
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
