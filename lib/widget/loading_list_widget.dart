import 'package:flutter/material.dart';
import 'package:flutter_news_app/widget/loading_news_card_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoadingListWidget extends StatelessWidget {
  const LoadingListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListView.builder(
        itemCount: 10,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12.px),
            child: LoadingNewsCardWidget(),
          );
        },
      ),
    );
  }
}
