import 'package:flutter/material.dart';
import 'package:flutter_news_app/view/webview/webview_page_controller.dart';
import 'package:flutter_news_app/widget/custom_error_widget.dart';
import 'package:flutter_news_app/widget/loading_widget.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatelessWidget {
  const WebviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: GetBuilder<WebviewPageController>(
            builder: (controller) {
              return controller.obx(
                (_) => WebViewWidget(controller: controller.webViewController),
                onLoading: LoadingWidget(),
                onError:
                    (error) => CustomErrorWidget(
                      error: error,
                      onRetry: () async => await controller.retry(),
                    ),
              );
            },
          ),
        ),
      ),
    );
  }
}
