import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/view/saved/saved_page_controller.dart';
import 'package:flutter_news_app/widget/custom_error_widget.dart';
import 'package:flutter_news_app/widget/loading_list_widget.dart';
import 'package:flutter_news_app/widget/news_card_widget.dart';
import 'package:flutter_news_app/widget/title_widget.dart';
import 'package:get/get.dart';

class SavedPage extends GetView<SavedPageController> {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SavedPageController>(
        initState: (state) async {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await controller.getSavedNews();
          });
        },
        builder: (_) {
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleWidget(
                  title: StringConstants.SAVED_PAGE_TITLE,
                  subtitle: StringConstants.SAVED_PAGE_SUBTITLE,
                ),
                _buildBody(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: controller.obx(
        (state) {
          return ListView.builder(
            itemCount: controller.list.length,
            itemBuilder: (context, index) {
              return NewsCardWidget(
                newsModel: controller.list[index],
                isFromSavedPage: true,
              );
            },
          );
        },
        onLoading: LoadingListWidget(),
        onEmpty: SizedBox(),
        onError:
            (error) => CustomErrorWidget(
              error: error,
              onRetry: () {
                controller.getSavedNews();
              },
            ),
      ),
    );
  }
}
