import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/util/validator.dart';
import 'package:flutter_news_app/core/model/states/auth_state.dart';
import 'package:flutter_news_app/view/auth/pages/mail/mail_page_controller.dart';
import 'package:flutter_news_app/widget/custom_button.dart';
import 'package:flutter_news_app/widget/custom_text_form_field.dart';
import 'package:flutter_news_app/widget/title_widget.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MailPage extends GetView<MailPageController> {
  const MailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(MailPageController()),
      builder: (_) {
        return Form(
          key: controller.mailFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 54.px),
              TitleWidget(
                title: StringConstants.MAIL_PAGE_TITLE,
                subtitle: StringConstants.MAIL_PAGE_SUBTITLE,
              ),
              CustomTextFormField(
                controller: controller.mailTextEditingController,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.px,
                  vertical: 16.px,
                ),
                hintText: StringConstants.MAIL_TEXT_FIELD_HINT,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => Validator.validateEmail(value),
                onChanged: (value) => controller.mail = value,
              ),
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
}
