import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPageController extends GetxController {
  late WebViewController webView;
  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;
  final String loginUrl = 'https://macxgain.com/login';

  @override
  void onInit() {
    super.onInit();
    _initializeWebView();
  }

  void _initializeWebView() {
    webView = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading progress if needed
          },
          onPageStarted: (String url) {
            isLoading.value = true;
            hasError.value = false;
          },
          onPageFinished: (String url) {
            isLoading.value = false;
            hasError.value = false;
          },
          onWebResourceError: (WebResourceError error) {
            isLoading.value = false;
            hasError.value = true;
            // Use debugPrint instead of print for production code
            debugPrint('WebView error: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            // Allow all navigation requests
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(loginUrl));
  }

  void retryLoading() {
    hasError.value = false;
    isLoading.value = true;
    webView.loadRequest(Uri.parse(loginUrl));
  }
}
