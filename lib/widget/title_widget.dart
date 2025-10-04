import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/config/theme/theme_extension.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const TitleWidget({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).primaryTextTheme.titleLarge?.bold,
          ),
          SizedBox(height: 6.px),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.semibold,
          ),
        ],
      ),
    );
  }
}
