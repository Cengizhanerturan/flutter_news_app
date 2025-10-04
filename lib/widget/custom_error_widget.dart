import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/config/theme/app_colors.dart';
import 'package:flutter_news_app/core/config/theme/theme_extension.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomErrorWidget extends StatelessWidget {
  final String? error;
  final String? buttonText;
  final Function? onRetry;
  const CustomErrorWidget({
    super.key,
    this.error,
    this.buttonText,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.4,
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            error ?? StringConstants.DEFAULT_ERROR_MESSAGE,
            style: Theme.of(context).primaryTextTheme.bodyMedium?.medium,
            textAlign: TextAlign.center,
          ),
          InkWell(
            onTap: () {
              if (onRetry != null) {
                onRetry!();
              }
            },
            child: Container(
              margin: EdgeInsets.only(top: 30.px),
              padding: EdgeInsets.symmetric(vertical: 10.px, horizontal: 30.px),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.px),
                color: Theme.of(context).primaryColor,
              ),
              child: Text(
                buttonText ?? StringConstants.RETRY_BUTTON_DEFAULT_TEXT,
                style: Theme.of(context).primaryTextTheme.bodyMedium?.medium
                    .copyWith(color: AppColorsLight.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
