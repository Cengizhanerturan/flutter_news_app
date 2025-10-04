import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/asset_constants.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/view/search/search_page_controller.dart';
import 'package:flutter_news_app/widget/custom_back_button.dart';
import 'package:flutter_news_app/widget/custom_error_widget.dart';
import 'package:flutter_news_app/widget/custom_text_form_field.dart';
import 'package:flutter_news_app/widget/loading_list_widget.dart';
import 'package:flutter_news_app/widget/news_card_widget.dart';
import 'package:flutter_news_app/widget/title_widget.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchPage extends GetView<SearchPageController> {
  const SearchPage({super.key});

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
              CustomBackButton(
                padding: EdgeInsets.only(left: 16.px, right: 16.px, top: 16.px),
              ),
              TitleWidget(
                title: StringConstants.SEARCH_PAGE_TITLE,
                subtitle: StringConstants.SEARCH_PAGE_SUBTITLE,
              ),
              _buildSearchField(context),
              _buildNewsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsList() {
    return Expanded(
      child: controller.obx(
        (state) {
          var newsList = controller.newsList;
          return ListView.builder(
            itemCount: newsList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(
                  top: index == 0 ? 12.px : 0,
                  bottom: index == newsList.length - 1 ? 12.px : 0,
                ),
                child: NewsCardWidget(newsModel: newsList[index]),
              );
            },
          );
        },
        onLoading: LoadingListWidget(),
        onError:
            (error) => CustomErrorWidget(
              error: error,
              onRetry: () {
                controller.onRetry();
              },
            ),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return CustomTextFormField(
      controller: controller.textEditingController,
      hintText: 'Search',
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      prefixIcon: ImageIcon(
        AssetImage(AssetConstants.search),
        color: Theme.of(context).hintColor,
      ),
      onChanged: controller.onTextChanged,
    );
  }
}
