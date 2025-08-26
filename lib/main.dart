import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_routes.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MacXainApp());
}

class MacXainApp extends StatelessWidget {
  const MacXainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MacXain Trading',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF1a1a2e),
        scaffoldBackgroundColor: const Color(0xFF1a1a2e), // Dark background to prevent white flash
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1a1a2e),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00d4ff),
          primary: const Color(0xFF1a1a2e),
          secondary: const Color(0xFF00d4ff),
        ),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
      home: const SplashScreen(),
    );
  }
}
