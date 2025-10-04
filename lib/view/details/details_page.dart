import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/config/theme/app_colors.dart';
import 'package:flutter_news_app/core/config/theme/theme_extension.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/util/extensions.dart';
import 'package:flutter_news_app/view/details/details_page_controller.dart';
import 'package:flutter_news_app/widget/custom_back_button.dart';
import 'package:flutter_news_app/widget/custom_cached_network_image.dart';
import 'package:flutter_news_app/widget/custom_save_button.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DetailsPage extends GetView<DetailsPageController> {
  final String controllerTag;
  const DetailsPage({super.key, required this.controllerTag});

  @override
  String? get tag => controllerTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [_buildImageArea(context), _buildContentArea(context)],
        ),
      ),
    );
  }

  Widget _buildContentArea(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: Get.width,
        height: Get.height * 0.67,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildSourceAndDateArea(context),
            _buildContent(context),
            _buildReadMoreButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildReadMoreButton(BuildContext context) {
    return Container(
      width: Get.width,
      height: 55.px,
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      margin: EdgeInsets.only(bottom: 10.px, top: 10.px),
      child: InkWell(
        onTap: () async {
          await controller.openNewsInWebview();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.px),
            color: Theme.of(context).primaryColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: SizedBox()),
              Expanded(
                child: Text(
                  StringConstants.READ_MORE_BUTTON_TEXT,
                  style: Theme.of(context).primaryTextTheme.bodyMedium?.semibold
                      .copyWith(color: AppColorsLight.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(child: _buildCircleArrowIcon(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircleArrowIcon(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 50.px,
        height: 50.px,
        margin: EdgeInsets.only(right: 2.5.px),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Icon(Icons.arrow_forward_ios_rounded, size: 30.px),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.6 - 65.px,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.px),
          topRight: Radius.circular(30.px),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.px),
          child: Column(
            children: [
              SizedBox(height: 16.px),
              _buildTitleText(context),
              SizedBox(height: 16.px),
              _buildContentText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleText(BuildContext context) {
    return Text(
      controller.newsModel.title,
      style: Theme.of(context).primaryTextTheme.bodyLarge?.semibold,
    );
  }

  Widget _buildContentText(BuildContext context) {
    return Text(
      controller.newsModel.content ?? "",
      style: Theme.of(context).primaryTextTheme.bodyMedium?.medium,
    );
  }

  Widget _buildSourceAndDateArea(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 6.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_buildSource(context), _buildDateText(context)],
      ),
    );
  }

  Widget _buildSource(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.px, vertical: 6.px),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.px),
        color: Theme.of(context).primaryColor,
      ),
      child: Text(
        controller.newsModel.source.name,
        style: Theme.of(context).primaryTextTheme.bodySmall?.medium.copyWith(
          color: AppColorsLight.white,
        ),
      ),
    );
  }

  Widget _buildDateText(BuildContext context) {
    return Text(
      controller.newsModel.publishedAt.formattedDate,
      style: Theme.of(context).primaryTextTheme.bodySmall?.medium.copyWith(
        color: AppColorsLight.white,
      ),
    );
  }

  Widget _buildImageArea(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.45,
      child: Stack(
        children: [
          CustomCachedNetworkImage(
            imageUrl: controller.newsModel.urlToImage,
            width: Get.width,
            height: Get.height * 0.5,
            isBorderRadius: false,
          ),
          _buildImageShadow(),
          _buildBackAndSaveButton(),
        ],
      ),
    );
  }

  Widget _buildBackAndSaveButton() {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomBackButton(),
          CustomSaveButton(
            isSaved: controller.isSaved,
            onTap: () async => await controller.toogleSaveButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildImageShadow() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: Get.height * 0.3,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [AppColorsLight.black, Colors.transparent],
          ),
          borderRadius: BorderRadius.circular(10.px),
        ),
      ),
    );
  }
}
