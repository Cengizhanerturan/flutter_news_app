import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/config/theme/theme_extension.dart';
import 'package:flutter_news_app/core/model/news_model.dart';
import 'package:flutter_news_app/core/util/extensions.dart';
import 'package:flutter_news_app/core/util/get_extension.dart';
import 'package:flutter_news_app/widget/custom_cached_network_image.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewsCardWidget extends StatelessWidget {
  final NewsModel newsModel;
  final bool isFromSavedPage;
  const NewsCardWidget({
    super.key,
    required this.newsModel,
    this.isFromSavedPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Get.toDetailsPage(
          newsModel: newsModel,
          isFromSavedPage: isFromSavedPage,
        );
      },
      child: Container(
        height: Get.width * 0.25,
        padding: EdgeInsets.symmetric(horizontal: 16.px),
        margin: EdgeInsets.only(bottom: 12.px),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCachedNetworkImage(
              imageUrl: newsModel.urlToImage,
              width: Get.width * 0.25,
              height: Get.width * 0.25,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8.px),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.px),
                      child: Text(
                        newsModel.source.name,
                        style: Theme.of(context).textTheme.bodySmall?.semibold,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          newsModel.title,
                          maxLines: 2,
                          style:
                              Theme.of(
                                context,
                              ).primaryTextTheme.bodyMedium?.semibold,
                          maxFontSize:
                              Theme.of(context)
                                  .primaryTextTheme
                                  .bodyMedium!
                                  .fontSize!
                                  .floorToDouble(),
                          minFontSize:
                              Theme.of(context)
                                  .primaryTextTheme
                                  .bodySmall!
                                  .fontSize!
                                  .floorToDouble(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.px),
                      child: Text(
                        newsModel.publishedAt.formattedDate,
                        style: Theme.of(context).textTheme.bodySmall?.semibold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
