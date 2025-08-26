import 'package:get/get.dart';
import '../screens/splash_screen.dart';
import '../screens/webview_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String webview = '/webview';

  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: webview,
      page: () => const WebViewScreen(),
    ),
  ];
}
