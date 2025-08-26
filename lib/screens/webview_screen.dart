import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controllers/webview_controller.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WebViewPageController());
    
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'MacXain Trading',
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   backgroundColor: const Color(0xFF1a1a2e),
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Colors.white),
      //     onPressed: () {
      //       controller.webView.goBack();
      //     },
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.refresh, color: Colors.white),
      //       onPressed: () {
      //         controller.webView.reload();
      //       },
      //     ),
      //     IconButton(
      //       icon: const Icon(Icons.home, color: Colors.white),
      //       onPressed: () {
      //         controller.webView.loadRequest(
      //           Uri.parse('https://macxgain.com/login'),
      //         );
      //       },
      //     ),
      //   ],
      // ),
      body: Stack(
        children: [
          // WebView
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF00d4ff),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Loading MacXain Trading Platform...',
                      style: TextStyle(
                        color: Color(0xFF1a1a2e),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }
            
            return WebViewWidget(
              controller: controller.webView,
            );
          }),
          
          // Error message overlay
          Obx(() {
            if (controller.hasError.value) {
              return Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Connection Error',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1a1a2e),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Unable to load the trading platform.\nPlease check your internet connection.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          controller.retryLoading();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00d4ff),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'Retry',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
