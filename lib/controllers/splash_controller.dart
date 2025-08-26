import 'package:get/get.dart';
import '../screens/webview_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToWebView();
  }

  void _navigateToWebView() {
    // Wait for 3 seconds to show the splash screen
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => const WebViewScreen());
    });
  }
}
