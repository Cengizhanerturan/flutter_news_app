import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomBackButton extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;
  const CustomBackButton({super.key, this.padding, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        } else {
          Get.back();
        }
      },
      child: Container(
        padding: EdgeInsets.all(8.px),
        margin: padding ?? EdgeInsets.symmetric(horizontal: 16.px),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).cardColor,
          border: Border.all(color: Theme.of(context).dividerColor, width: 1),
        ),
        child: Icon(Icons.arrow_back_ios_rounded, size: 20.px),
      ),
    );
  }
}
