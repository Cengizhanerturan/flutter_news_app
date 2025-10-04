import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skeleton_text/skeleton_text.dart';

class LoadingSliderWidget extends StatelessWidget {
  const LoadingSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          SizedBox(
            height: Get.width * 0.5,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.px),
              child: SizedBox(
                width: Get.width,
                height: Get.width * 0.5,
                child: SkeletonAnimation(
                  shimmerColor: Theme.of(
                    context,
                  ).dividerColor.withValues(alpha: 0.5),
                  gradientColor: Theme.of(context).dividerColor,
                  borderRadius: BorderRadius.circular(10.px),
                  child: Container(
                    width: Get.width,
                    height: Get.width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.px),
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.px),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Container(
                  width: 10.px,
                  height: 10.px,
                  margin: EdgeInsets.symmetric(horizontal: 2.px),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).cardColor,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
