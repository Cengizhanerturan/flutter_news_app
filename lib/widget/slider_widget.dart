import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_news_app/core/config/theme/app_colors.dart';
import 'package:flutter_news_app/core/config/theme/theme_extension.dart';
import 'package:flutter_news_app/core/model/news_model.dart';
import 'package:flutter_news_app/core/util/get_extension.dart';
import 'package:flutter_news_app/widget/custom_cached_network_image.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SliderWidget extends StatelessWidget {
  final double width;
  final double height;
  final List<NewsModel> list;
  final RxInt currentPage;
  final void Function(int) onPageChanged;
  const SliderWidget({
    super.key,
    required this.width,
    required this.height,
    required this.list,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height,
          child: PageView.builder(
            itemCount: list.length,
            onPageChanged: onPageChanged,
            itemBuilder: (BuildContext context, int index) {
              final newsModel = list[index];
              return InkWell(
                onTap: () async {
                  await Get.toDetailsPage(newsModel: newsModel);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.px),
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Stack(
                      children: [
                        CustomCachedNetworkImage(
                          imageUrl: newsModel.urlToImage,
                          width: width,
                          height: height,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: height * 0.8,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  AppColorsLight.black,
                                  Colors.transparent,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10.px),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 6.px,
                          left: 10.px,
                          right: 10.px,
                          child: AutoSizeText(
                            newsModel.title,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .titleSmall
                                ?.semibold
                                .copyWith(color: AppColorsLight.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Positioned(
                          top: 6.px,
                          right: 10.px,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.px,
                              vertical: 3.px,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.px),
                              color: AppColorsLight.primary,
                            ),
                            child: Text(
                              newsModel.source.name,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodySmall
                                  ?.semibold
                                  .copyWith(color: AppColorsLight.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.px),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(list.length, (index) {
                return Container(
                  width: index == currentPage.value ? 10.px : 8.px,
                  height: index == currentPage.value ? 10.px : 8.px,
                  margin: EdgeInsets.symmetric(horizontal: 2.px),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        index == currentPage.value
                            ? AppColorsLight.primary
                            : AppColorsLight.darkGrey,
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
