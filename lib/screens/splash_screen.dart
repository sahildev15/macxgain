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
  late AnimationController _particleController;
  
  late Animation<double> _logoScale;
  late Animation<double> _logoRotation;
  late Animation<double> _textOpacity;
  late Animation<double> _featureOpacity;
  late Animation<double> _loadingOpacity;
  late Animation<double> _particleAnimation;

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
    
    _particleController = AnimationController(
      duration: const Duration(seconds: 3),
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
    
    _particleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _particleController, curve: Curves.linear),
    );
    
    // Start animations in sequence
    _startAnimations();
  }
  
  void _startAnimations() async {
    _particleController.repeat(); // Start particle animation immediately and repeat
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
    _particleController.dispose();
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
        child: Stack(
          children: [
            // Animated particles background
            AnimatedBuilder(
              animation: _particleAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: ParticlePainter(_particleAnimation.value),
                  size: Size.infinite,
                );
              },
            ),
            SafeArea(
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
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  const Icon(
                                    Icons.psychology,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                  Positioned(
                                    right: 8,
                                    top: 8,
                                    child: Container(
                                      width: 16,
                                      height: 16,
                                      decoration: const BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.trending_up,
                                        size: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
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
                              'Trade with AI',
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
                              'AI-Powered Trading Intelligence',
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
                                    icon: Icons.psychology,
                                    text: 'AI Market Analysis',
                                  ),
                                  const SizedBox(height: 15),
                                  _buildFeatureItem(
                                    icon: Icons.auto_awesome,
                                    text: 'Smart Predictions',
                                  ),
                                  const SizedBox(height: 15),
                                  _buildFeatureItem(
                                    icon: Icons.rocket_launch,
                                    text: 'Automated Trading',
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
                              'Initializing AI Engine...',
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
          ],
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

class ParticlePainter extends CustomPainter {
  final double animationValue;
  
  ParticlePainter(this.animationValue);
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00d4ff).withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;
    
    // Create floating particles
    for (int i = 0; i < 20; i++) {
      final x = (size.width * (i * 0.1 + animationValue * 0.5)) % size.width;
      final y = (size.height * (i * 0.15 + animationValue * 0.3)) % size.height;
      final radius = 2.0 + (i % 3);
      
      canvas.drawCircle(
        Offset(x, y),
        radius,
        paint..color = const Color(0xFF00d4ff).withValues(alpha: 0.1 + (i % 3) * 0.05),
      );
    }
    
    // Add some connecting lines for a tech feel
    final linePaint = Paint()
      ..color = const Color(0xFF00d4ff).withValues(alpha: 0.05)
      ..strokeWidth = 1;
    
    for (int i = 0; i < 10; i++) {
      final startX = (size.width * (i * 0.2 + animationValue * 0.1)) % size.width;
      final startY = (size.height * (i * 0.3 + animationValue * 0.2)) % size.height;
      final endX = (size.width * (i * 0.25 + animationValue * 0.15)) % size.width;
      final endY = (size.height * (i * 0.35 + animationValue * 0.25)) % size.height;
      
      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        linePaint,
      );
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
