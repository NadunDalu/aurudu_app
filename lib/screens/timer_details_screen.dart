import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class TimerDetailsScreen extends StatelessWidget {
  const TimerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Timer Details',
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Text(
            'Timer Details Screen\nMore details about the countdown can go here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              color: Colors.white, // Already white
              fontFamily: 'TharuDigitalNikini',
            ),
          ),
        ),
      ),
    );
  }
}