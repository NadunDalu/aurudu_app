import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'splash_screen.dart';
import 'audio/background_audio_controller.dart';
import 'utils/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  // Initialize notification service and schedule nakath alerts
  final notifService = NotificationService();
  await notifService.init();
  await notifService.requestPermissions();
  await notifService.scheduleNakathAlerts();

  // Test Firestore
  try {
    FirebaseFirestore.instance.collection('test').add({
      'message': 'Hello Firebase',
    });
    print("Firestore test code executed successfully!");
  } catch (e) {
    print("Error executing Firestore test: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Start background music after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BackgroundAudioController().init();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final bgm = BackgroundAudioController();
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      bgm.onAppPaused();
    } else if (state == AppLifecycleState.resumed) {
      bgm.onAppResumed();
    }
  }

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
