import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/model/states/state.dart';
import 'package:flutter_news_app/core/util/validator.dart';
import 'package:flutter_news_app/view/setting/update_user_information/update_user_information_page_controller.dart';
import 'package:flutter_news_app/widget/custom_back_button.dart';
import 'package:flutter_news_app/widget/custom_button.dart';
import 'package:flutter_news_app/widget/custom_text_form_field.dart';
import 'package:flutter_news_app/widget/title_widget.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UpdateUserInformationPage
    extends GetView<UpdateUserInformationPageController> {
  const UpdateUserInformationPage({super.key});

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
                  title: StringConstants.UPDATE_USER_INFORMATION_PAGE_TITLE,
                  subtitle:
                      StringConstants.UPDATE_USER_INFORMATION_PAGE_SUBTITLE,
                ),
                CustomTextFormField(
                  controller: controller.nameTextEditingController,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.px,
                    vertical: 16.px,
                  ),
                  hintText: StringConstants.NAME_TEXT_FIELD_HINT,
                  keyboardType: TextInputType.name,
                  validator: (value) => Validator.validateName(value),
                  onChanged: (value) => controller.name = value,
                ),
                CustomTextFormField(
                  controller: controller.surnameTextEditingController,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.px,
                    vertical: 16.px,
                  ),
                  hintText: StringConstants.SURNAME_TEXT_FIELD_HINT,
                  keyboardType: TextInputType.name,
                  validator: (value) => Validator.validateSurname(value),
                  onChanged: (value) => controller.surname = value,
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
