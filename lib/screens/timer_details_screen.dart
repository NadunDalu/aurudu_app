import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../app_theme.dart';

class TimerDetailsScreen extends StatelessWidget {
  const TimerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: 'Timer Details'),
      body: AuruduTheme.backgroundStack(
        child: SafeArea(
          child: Center(
            child: AuruduTheme.glassContainer(
              opacity: 0.15,
              child: const Text(
                'Timer Details Screen\nMore details about the countdown can go here.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  color: AuruduTheme.warmWhite,
                  fontFamily: 'TharuDigitalNikini',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
