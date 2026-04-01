import 'package:flutter/material.dart';

/// Centralized Aurudu App Design System
class AuruduTheme {
  // ─── Colors ───────────────────────────────────────
  static const Color deepMaroon = Color(0xFF5C0000);
  static const Color festiveRed = Color(0xFF8B1A1A);
  static const Color warmSaffron = Color(0xFFC0392B);
  static const Color gold = Color(0xFFD4AF37);
  static const Color lightGold = Color(0xFFF4D03F);
  static const Color cream = Color(0xFFFDF6E3);
  static const Color warmWhite = Color(0xFFFFF8E7);
  static const Color darkBg = Color(0xFF1A0000);

  // ─── Gradients ────────────────────────────────────
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xCC8B1A1A), // festiveRed with opacity
      Color(0xDD5C0000), // deepMaroon with opacity
      Color(0xFF1A0000), // darkBg
    ],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    colors: [festiveRed, deepMaroon],
  );

  static const LinearGradient goldShimmer = LinearGradient(
    colors: [gold, lightGold, gold],
  );

  // ─── Glass Card Decoration ────────────────────────
  static BoxDecoration glassCard({double opacity = 0.12, double radius = 24}) {
    return BoxDecoration(
      color: cream.withAlpha((opacity * 255).toInt()),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: gold.withAlpha((0.3 * 255).toInt()),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha((0.2 * 255).toInt()),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: gold.withAlpha((0.05 * 255).toInt()),
          blurRadius: 20,
          spreadRadius: -2,
        ),
      ],
    );
  }

  // ─── Solid Card Decoration (for song/nakath lists) ─
  static BoxDecoration solidGlassCard({double radius = 20}) {
    return BoxDecoration(
      color: cream.withAlpha((0.92 * 255).toInt()),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: gold.withAlpha((0.4 * 255).toInt()),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha((0.15 * 255).toInt()),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  // ─── Background Stack (gradient over bg.png) ──────
  static Widget backgroundStack({required Widget child}) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/bg.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(gradient: backgroundGradient),
          ),
        ),
        child,
      ],
    );
  }

  // ─── Glass Container Widget (NO BackdropFilter) ───
  static Widget glassContainer({
    required Widget child,
    double opacity = 0.12,
    double radius = 24,
    EdgeInsetsGeometry padding = const EdgeInsets.all(20),
    EdgeInsetsGeometry margin = const EdgeInsets.symmetric(vertical: 8),
  }) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: glassCard(opacity: opacity, radius: radius),
      child: child,
    );
  }

  // ─── Text Styles ──────────────────────────────────
  static const TextStyle titleGold = TextStyle(
    fontSize: 28,
    fontFamily: 'TharuDigitalNikini',
    color: gold,
    shadows: [
      Shadow(color: Colors.black54, blurRadius: 4, offset: Offset(0, 2)),
    ],
  );

  static const TextStyle subtitleGold = TextStyle(
    fontSize: 22,
    fontFamily: 'TharuDigitalNikini',
    color: gold,
  );

  static const TextStyle bodyWhite = TextStyle(
    fontSize: 16,
    fontFamily: 'FM_ARJUN',
    color: warmWhite,
    fontWeight: FontWeight.bold,
    height: 1.5,
  );

  static const TextStyle captionGold = TextStyle(
    fontSize: 12,
    fontFamily: 'TharuDigitalNikini',
    color: gold,
  );

  static const TextStyle timerNumber = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: gold,
    fontFamily: 'Gafata-Regular',
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 20,
    fontFamily: 'TharuDigitalNikini',
    color: deepMaroon,
  );

  static const TextStyle footerText = TextStyle(
    fontSize: 13,
    color: Colors.white54,
  );
}
