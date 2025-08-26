import 'package:get/get.dart';
import '../screens/webview_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToWebView();
  }

  void _navigateToWebView() {
    // Wait for 5 seconds to show all splash screen content and animations
    Future.delayed(const Duration(seconds: 5), () {
      Get.off(() => const WebViewScreen());
    });
  }
}
