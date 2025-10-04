import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/asset_constants.dart';
import 'package:flutter_news_app/core/constants/enums.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/service/routes/app_routes.dart';
import 'package:flutter_news_app/view/discover/discover_page_controller.dart';
import 'package:flutter_news_app/widget/custom_error_widget.dart';
import 'package:flutter_news_app/widget/custom_tabbar.dart';
import 'package:flutter_news_app/widget/custom_text_form_field.dart';
import 'package:flutter_news_app/widget/loading_list_widget.dart';
import 'package:flutter_news_app/widget/news_card_widget.dart';
import 'package:flutter_news_app/widget/title_widget.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DiscoverPage extends GetView<DiscoverPageController> {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(
                title: StringConstants.DISCOVER_PAGE_TITLE,
                subtitle: StringConstants.DISCOVER_PAGE_SUBTITLE,
              ),
              _buildSearchField(context),
              _buildTabbar(),
              _buildPageView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return Expanded(
      child: PageView.builder(
        itemCount: NEWS_CATEGORY.values.length,
        controller: controller.pageController,
        onPageChanged: (value) {
          controller.currentIndex.value = value;
          controller.tabController.animateTo(value);
        },
        itemBuilder: (BuildContext context, int pageViewIndex) {
          return _buildNewsList(pageViewIndex);
        },
      ),
    );
  }

  Widget _buildNewsList(int pageViewIndex) {
    return controller.obx(
      (state) {
        var newsList = controller.currentNewsList(pageViewIndex);
        return ListView.builder(
          itemCount: newsList.length,
          itemBuilder: (BuildContext context, int listViewItemIndex) {
            return NewsCardWidget(newsModel: newsList[listViewItemIndex]);
          },
        );
      },
      onLoading: LoadingListWidget(),
      onError:
          (error) => CustomErrorWidget(
            error: error,
            onRetry: () {
              controller.fetchNews();
            },
          ),
    );
  }

  Widget _buildTabbar() {
    return CustomTabbar(
      tabController: controller.tabController,
      tabTitleList: controller.tabTitleList,
      currentIndex: controller.currentIndex,
      onTap: (index) async {
        controller.currentIndex.value = index;
        await controller.pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      },
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Get.toNamed(Routes.SEARCH);
      },
      child: CustomTextFormField(
        controller: TextEditingController(),
        hintText: 'Search',
        enabled: false,
        padding: EdgeInsets.symmetric(horizontal: 16.px),
        prefixIcon: ImageIcon(
          AssetImage(AssetConstants.search),
          color: Theme.of(context).hintColor,
        ),
      ),
    );
  }
}
