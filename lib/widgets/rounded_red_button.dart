import 'package:flutter/material.dart';
import '../app_theme.dart';

class RoundedRedButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RoundedRedButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AuruduTheme.buttonGradient,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AuruduTheme.festiveRed.withAlpha((0.4 * 255).toInt()),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 36),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: onPressed,
        child: const Text(
          'ó,Õ kel;',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'TharuDigitalNikini',
            color: AuruduTheme.gold,
          ),
        ),
      ),
    );
  }
}
