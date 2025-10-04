import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/asset_constants.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomSaveButton extends StatelessWidget {
  final RxBool isSaved;
  final void Function() onTap;
  const CustomSaveButton({
    super.key,
    required this.isSaved,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.all(8.px),
        margin: EdgeInsets.symmetric(horizontal: 16.px),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).cardColor,
          border: Border.all(color: Theme.of(context).dividerColor, width: 1),
        ),
        child: Obx(
          () => ImageIcon(
            AssetImage(
              isSaved.value ? AssetConstants.savedActive : AssetConstants.saved,
            ),
            size: 20.px,
          ),
        ),
      ),
    );
  }
}
