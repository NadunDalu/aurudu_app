import 'package:flutter/material.dart';
import 'dart:async';
import 'dashboard_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _scale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const DashboardScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 600),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/bg.png',
            fit: BoxFit.cover,
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.2,
                colors: [
                  AuruduTheme.festiveRed.withAlpha((0.7 * 255).toInt()),
                  AuruduTheme.deepMaroon.withAlpha((0.85 * 255).toInt()),
                  AuruduTheme.darkBg.withAlpha((0.95 * 255).toInt()),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
          // Content
          Center(
            child: FadeTransition(
              opacity: _fadeIn,
              child: ScaleTransition(
                scale: _scale,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Couple image with gold border
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AuruduTheme.gold.withAlpha((0.6 * 255).toInt()),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AuruduTheme.gold.withAlpha((0.3 * 255).toInt()),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          'assets/images/couple.png',
                          width: 160,
                          height: 160,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Title with gold shimmer
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          AuruduTheme.goldShimmer.createShader(bounds),
                      child: const Text(
                        'kele;a iSÜgqj',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'TharuDigitalNikini',
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '2026',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                        color: AuruduTheme.warmWhite,
                        fontFamily: 'Gafata-Regular',
                        letterSpacing: 8,
                      ),
                    ),
                    const SizedBox(height: 50),
                    // Loading Animation
                    LoadingAnimationWidget.staggeredDotsWave(
                      color: AuruduTheme.gold,
                      size: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
