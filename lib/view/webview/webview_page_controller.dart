import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPageController extends GetxController with StateMixin {
  final String url;
  WebviewPageController({required this.url});

  late final WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();
    webViewController =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (url) => change(null, status: RxStatus.loading()),
              onPageFinished: (url) => change(null, status: RxStatus.success()),
              onWebResourceError:
                  (error) =>
                      change(null, status: RxStatus.error(error.description)),
            ),
          )
          ..loadRequest(Uri.parse(url));
  }

  Future<void> retry() async {
    await webViewController.reload();
  }
}
