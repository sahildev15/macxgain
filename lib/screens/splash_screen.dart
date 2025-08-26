import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _featureController;
  late AnimationController _loadingController;
  
  late Animation<double> _logoScale;
  late Animation<double> _logoRotation;
  late Animation<double> _textOpacity;
  late Animation<double> _featureOpacity;
  late Animation<double> _loadingOpacity;

  @override
  void initState() {
    super.initState();
    Get.put(SplashController());
    
    // Initialize animation controllers
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _featureController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _loadingController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    // Initialize animations
    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );
    
    _logoRotation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );
    
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeIn),
    );
    
    _featureOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _featureController, curve: Curves.easeIn),
    );
    
    _loadingOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _loadingController, curve: Curves.easeIn),
    );
    
    // Start animations in sequence
    _startAnimations();
  }
  
  void _startAnimations() async {
    await _logoController.forward();
    await _textController.forward();
    await _featureController.forward();
    await _loadingController.forward();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _featureController.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1a1a2e),
              Color(0xFF16213e),
              Color(0xFF0f3460),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top section with logo and title
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Logo/Icon with Animation
                    AnimatedBuilder(
                      animation: _logoController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _logoScale.value,
                          child: Transform.rotate(
                            angle: _logoRotation.value * 0.1,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF00d4ff),
                                    Color(0xFF0099cc),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF00d4ff).withValues(alpha: 0.4),
                                    blurRadius: 25,
                                    spreadRadius: 8,
                                  ),
                                  BoxShadow(
                                    color: const Color(0xFF00d4ff).withValues(alpha: 0.2),
                                    blurRadius: 40,
                                    spreadRadius: 15,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.trending_up,
                                size: 60,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    
                    // App Name with Animation
                    AnimatedBuilder(
                      animation: _textController,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _textOpacity.value,
                          child: Transform.translate(
                            offset: Offset(0, 20 * (1 - _textOpacity.value)),
                            child: const Text(
                              'Macxgain',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    
                    // Tagline with Animation
                    AnimatedBuilder(
                      animation: _textController,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _textOpacity.value,
                          child: Transform.translate(
                            offset: Offset(0, 15 * (1 - _textOpacity.value)),
                            child: Text(
                              'Professional Trading Platform',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withValues(alpha: 0.8),
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    
                    // Feature highlights with Animation
                    AnimatedBuilder(
                      animation: _featureController,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _featureOpacity.value,
                          child: Transform.translate(
                            offset: Offset(0, 30 * (1 - _featureOpacity.value)),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  _buildFeatureItem(
                                    icon: Icons.analytics,
                                    text: 'Advanced Analytics',
                                  ),
                                  const SizedBox(height: 15),
                                  _buildFeatureItem(
                                    icon: Icons.security,
                                    text: 'Secure Trading',
                                  ),
                                  const SizedBox(height: 15),
                                  _buildFeatureItem(
                                    icon: Icons.speed,
                                    text: 'Real-time Data',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              
              // Bottom section with loading indicator
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Loading indicator with Animation
                    AnimatedBuilder(
                      animation: _loadingController,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _loadingOpacity.value,
                          child: Transform.translate(
                            offset: Offset(0, 20 * (1 - _loadingOpacity.value)),
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  const Color(0xFF00d4ff),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    
                    // Loading text with Animation
                    AnimatedBuilder(
                      animation: _loadingController,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _loadingOpacity.value,
                          child: Transform.translate(
                            offset: Offset(0, 10 * (1 - _loadingOpacity.value)),
                            child: Text(
                              'Loading...',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withValues(alpha: 0.7),
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String text,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: const Color(0xFF00d4ff).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(22.5),
            border: Border.all(
              color: const Color(0xFF00d4ff).withValues(alpha: 0.6),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00d4ff).withValues(alpha: 0.2),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(
            icon,
            color: const Color(0xFF00d4ff),
            size: 22,
          ),
        ),
        const SizedBox(width: 18),
        Text(
          text,
          style: TextStyle(
            fontSize: 15,
            color: Colors.white.withValues(alpha: 0.95),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
