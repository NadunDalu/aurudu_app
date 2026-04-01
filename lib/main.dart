import 'package:flutter/material.dart';
import 'splash_screen.dart';
import '../audio/background_audio_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BackgroundAudioController().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const SplashScreen(),
    );
  }
}
