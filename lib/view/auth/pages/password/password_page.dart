import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/enums.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/util/validator.dart';
import 'package:flutter_news_app/core/model/states/auth_state.dart';
import 'package:flutter_news_app/view/auth/pages/password/password_page_controller.dart';
import 'package:flutter_news_app/widget/custom_back_button.dart';
import 'package:flutter_news_app/widget/custom_button.dart';
import 'package:flutter_news_app/widget/custom_text_form_field.dart';
import 'package:flutter_news_app/widget/title_widget.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PasswordPage extends GetView<PasswordPageController> {
  const PasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(PasswordPageController()),
      builder: (_) {
        return Form(
          key: controller.passwordFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(
                padding: EdgeInsets.only(left: 16.px, right: 16.px, top: 16.px),
                onTap: () => controller.backToPage(),
              ),
              _buildTitleWidget(),
              _buildPasswordTextField(),
              _buildRepasswordTextField(),
              Obx(
                () => CustomButton(
                  buttonText: StringConstants.CONTINUE_BUTTON_TEXT,
                  onTap: () {
                    controller.onTap(context);
                  },
                  isEnabled: controller.isButtonEnabled,
                  isLoading: controller.state is AuthStateLoading,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTitleWidget() {
    if (controller.authType == AUTH_TYPE.LOGIN) {
      return TitleWidget(
        title: StringConstants.PASSWORD_PAGE_LOGIN_TITLE,
        subtitle: StringConstants.PASSWORD_PAGE_SUBTITLE,
      );
    }
    return TitleWidget(
      title: StringConstants.PASSWORD_PAGE_REGISTER_TITLE,
      subtitle: StringConstants.PASSWORD_PAGE_SUBTITLE,
    );
  }

  Widget _buildPasswordTextField() {
    return CustomTextFormField(
      controller: controller.passwordTextEditingController,
      isPassword: true,
      padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 16.px),
      hintText: StringConstants.PASSWORD_TEXT_FIELD_HINT,
      keyboardType: TextInputType.visiblePassword,
      validator: (value) => Validator.validatePassword(value),
      onChanged: (value) => controller.onChangedPassword = value,
    );
  }

  Widget _buildRepasswordTextField() {
    if (controller.authType == AUTH_TYPE.LOGIN) {
      return const SizedBox.shrink();
    }
    return CustomTextFormField(
      controller: controller.rePasswordTextEditingController,
      isPassword: true,
      padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 16.px),
      hintText: StringConstants.REPEAT_PASSWORD_TEXT_FIELD_HINT,
      keyboardType: TextInputType.visiblePassword,
      validator:
          (value) => Validator.validateRePassword(controller.password, value),
      onChanged: (value) => controller.onChangedRepassword = value,
    );
  }
}
