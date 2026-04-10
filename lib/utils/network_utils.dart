import 'package:flutter/material.dart';
import '../app_theme.dart';

class NetworkUtils {
  static void showNetworkErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AuruduTheme.darkBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titlePadding: const EdgeInsets.only(top: 10, right: 10),
        contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 24),
        title: Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.white70),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off, color: AuruduTheme.festiveRed, size: 48),
            const SizedBox(height: 20),
            const Text(
              'Tnf.a wka;¾cd, in|;jh msßlaid n,kak æ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'FM_ARJUN',
                fontSize: 24,
                color: AuruduTheme.gold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '(මේ සඳහා ඔබේ අන්තර්ජාල සබඳතාව අවශ්‍ය බව කරුණාවෙන් සලකන්න.)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: AuruduTheme.warmWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
