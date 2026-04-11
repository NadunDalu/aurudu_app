import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../data/nakath_data.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Initialize timezone engine
    tz.initializeTimeZones();

    // The icon must exist in android/app/src/main/res/drawable/ or mipmap/
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    // Initialize the plugin natively
    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );
  }

  // Request notifications (Android 13+) and Exact Alarm permission
  Future<void> requestPermissions() async {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidImplementation != null) {
      await androidImplementation.requestNotificationsPermission();
      await androidImplementation.requestExactAlarmsPermission();
    }
  }

  // Loops all nakaths and actively schedules the 6 unique countdown variants
  Future<void> scheduleNakathAlerts() async {
    // Clear all previously scheduled to prevent ghost duplicates across reboots/changes
    await flutterLocalNotificationsPlugin.cancelAll();

    final now = DateTime.now();
    int notificationId = 1000; // start at a safe arbitrary ID

    for (var event in nakathEvents) {
      // If the Nakath has completely passed, skip it
      if (event.dateTime.isBefore(now)) continue;

      final Map<int, String> alerts = {
        15: 'ට තව විනාඩි 15යි',
        10: 'ට තව විනාඩි 10යි',
        5: 'ට තව විනාඩි 5යි',
        0: 'නැකත දැන් උදාවුනා!',
      };

      for (var entry in alerts.entries) {
        final alertTime = event.dateTime.subtract(Duration(minutes: entry.key));
        
        // Only schedule if this specific warning marker is in the future
        if (alertTime.isAfter(now)) {
          await _scheduleNotification(
            id: notificationId++,
            title: 'Nekath Seettuwa 2026',
            body: '${event.unicodeTitle} ${entry.value}',
            scheduledDate: alertTime,
            // If the time is NOW, give a slightly more dramatic alert
            isHighPriority: entry.key == 0,
          );
        }
      }
    }
  }

  Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    bool isHighPriority = false,
  }) async {
    final location = tz.local; // Map to the device's current timezone context
    final scheduledDateTz = tz.TZDateTime.from(scheduledDate, location);

    final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'nakath_channel_id',
      'Nakath Alerts',
      channelDescription: 'Notifications for upcoming Nakath times',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      enableVibration: true,
      playSound: true,
      styleInformation: BigTextStyleInformation(body),
    );

    final NotificationDetails platformDetails =
        NotificationDetails(android: androidDetails);

    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: scheduledDateTz,
        notificationDetails: platformDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
      debugPrint('Scheduled: $body at $scheduledDateTz');
    } catch (e) {
      debugPrint('Error scheduling notification: $e');
    }
  }
}
