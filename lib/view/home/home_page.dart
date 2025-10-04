import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/config/theme/app_colors.dart';
import 'package:flutter_news_app/core/config/theme/theme_extension.dart';
import 'package:flutter_news_app/core/constants/asset_constants.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/service/routes/app_routes.dart';
import 'package:flutter_news_app/view/home/home_page_controller.dart';
import 'package:flutter_news_app/widget/custom_error_widget.dart';
import 'package:flutter_news_app/widget/error_image_widget.dart';
import 'package:flutter_news_app/widget/loading_list_widget.dart';
import 'package:flutter_news_app/widget/loading_slider_widget.dart';
import 'package:flutter_news_app/widget/news_card_widget.dart';
import 'package:flutter_news_app/widget/slider_widget.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTopBar(context),
              _buildBreakingNews(context),
              _buildRecommendatitonNews(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendatitonNews(BuildContext context) {
    return Column(
      children: [
        _buildTitleArea(context, StringConstants.RECOMMENDATION),
        controller.obx(
          (state) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListView.builder(
                itemCount: controller.newsList.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final newsModel = controller.newsList[index];
                  return NewsCardWidget(newsModel: newsModel);
                },
              ),
            );
          },
          onEmpty: LoadingListWidget(),
          onLoading: LoadingListWidget(),
          onError:
              (error) => CustomErrorWidget(
                error: error,
                onRetry: () {
                  controller.fetchNews();
                },
              ),
        ),
      ],
    );
  }

  Widget _buildBreakingNews(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitleArea(context, StringConstants.BREAKING_NEWS),
          controller.obx(
            (state) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SliderWidget(
                  width: Get.width,
                  height: Get.width * 0.5,
                  list: controller.sliderNewsList,
                  currentPage: controller.sliderCurrentPage,
                  onPageChanged: (index) {
                    controller.sliderCurrentPage.value = index;
                  },
                ),
              );
            },
            onLoading: LoadingSliderWidget(),
            onError:
                (error) => Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.px,
                    vertical: 10.px,
                  ),
                  child: Column(
                    children: [
                      ErrorImageWidget(
                        width: Get.width,
                        height: Get.width * 0.5,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0),
                        child: SizedBox(height: 10.px),
                      ),
                    ],
                  ),
                ),
            onEmpty: LoadingSliderWidget(),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleArea(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTitleText(context, title),
          _buildViewAllButton(context),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 16.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringConstants.WELCOME,
                style: Theme.of(context).textTheme.bodySmall?.semibold,
              ),
              Text(
                controller.userInformation,
                style: Theme.of(context).primaryTextTheme.bodySmall?.semibold,
              ),
            ],
          ),
          _buildSearchIcon(context),
        ],
      ),
    );
  }

  Widget _buildSearchIcon(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Get.toNamed(Routes.SEARCH);
      },
      child: Container(
        padding: EdgeInsets.all(8.px),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).cardColor,
          border: Border.all(color: Theme.of(context).dividerColor, width: 1),
        ),
        child: ImageIcon(
          AssetImage(AssetConstants.search),
          color: Theme.of(context).iconTheme.color,
          size: 20.px,
        ),
      ),
    );
  }

  Widget _buildTitleText(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).primaryTextTheme.titleSmall?.semibold,
    );
  }

  Widget _buildViewAllButton(BuildContext context) {
    return Text(
      StringConstants.VIEW_ALL,
      style: Theme.of(context).primaryTextTheme.bodySmall?.semibold.copyWith(
        color: AppColorsLight.primary,
      ),
    );
  }
}
