import 'package:flutter/material.dart';
import '../app_theme.dart';

class RoundedWhiteButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RoundedWhiteButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: AuruduTheme.cream.withAlpha((0.15 * 255).toInt()),
        side: const BorderSide(
          color: AuruduTheme.gold,
          width: 1.5,
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 36),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      onPressed: onPressed,
      child: const Text(
        'fmr kel;',
        style: TextStyle(
          fontSize: 18,
          fontFamily: 'TharuDigitalNikini',
          color: AuruduTheme.gold,
        ),
      ),
    );
  }
}
