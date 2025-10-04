import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/config/theme/app_colors.dart';
import 'package:flutter_news_app/core/config/theme/theme_extension.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTabbar extends StatelessWidget {
  final TabController tabController;
  final List<String> tabTitleList;
  final RxInt currentIndex;
  final void Function(int index)? onTap;
  const CustomTabbar({
    super.key,
    required this.tabController,
    required this.tabTitleList,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      onTap: onTap,
      dividerColor: Colors.transparent,
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      splashFactory: NoSplash.splashFactory,
      tabs: List.generate(tabTitleList.length, (int index) {
        final title = tabTitleList[index];
        return Obx(
          () => Tab(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 4.px),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.px),
                color:
                    currentIndex.value == index
                        ? AppColorsLight.primary
                        : Theme.of(context).cardColor,
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 1.px,
                ),
              ),
              child: Text(
                title,
                style: Theme.of(
                  context,
                ).primaryTextTheme.bodyMedium?.semibold.copyWith(
                  color:
                      currentIndex.value == index
                          ? AppColorsLight.white
                          : Theme.of(context).unselectedWidgetColor,
                ),
              ),
            ),
          ),
        );
      }),
      padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 10.px),
      labelPadding: EdgeInsets.symmetric(horizontal: 6.px),
      indicatorPadding: EdgeInsets.zero,
      unselectedLabelColor: AppColorsLight.textPrimary,
      labelColor: AppColorsLight.white,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(30.px),
        color: Colors.transparent,
      ),
    );
  }
}
