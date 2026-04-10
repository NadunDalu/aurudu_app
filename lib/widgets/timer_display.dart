import 'package:flutter/material.dart';
import 'dart:async';
import '../app_theme.dart';

class TimerDisplay extends StatefulWidget {
  final DateTime targetDateTime;
  final VoidCallback? onComplete;

  const TimerDisplay({
    super.key,
    required this.targetDateTime,
    this.onComplete,
  });

  @override
  State<TimerDisplay> createState() => _TimerDisplayState();
}

class _TimerDisplayState extends State<TimerDisplay> {
  late Duration _timeLeft;
  late Timer _timer;
  bool _hasCompleted = false;

  String formatDigits(int n) => n.toString().padLeft(2, '0');

  @override
  void initState() {
    super.initState();
    _timeLeft = Duration.zero;
    _updateTimeLeft();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateTimeLeft();
    });
  }

  void _updateTimeLeft() {
    final now = DateTime.now();
    final diff = widget.targetDateTime.difference(now);
    
    if (diff.isNegative) {
      if (!_hasCompleted) {
        _hasCompleted = true;
        widget.onComplete?.call();
      }
      setState(() {
        _timeLeft = Duration.zero;
      });
    } else {
      setState(() {
        _timeLeft = diff;
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget _buildTimeBox(String value, String label) {
    return Column(
      children: [
        Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            color: AuruduTheme.cream.withAlpha((0.15 * 255).toInt()),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AuruduTheme.gold.withAlpha((0.4 * 255).toInt()),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              value,
              style: AuruduTheme.timerNumber,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontFamily: 'TharuDigitalNikini',
            color: AuruduTheme.warmWhite,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final days = formatDigits(_timeLeft.inDays);
    final hours = formatDigits(_timeLeft.inHours % 24);
    final minutes = formatDigits(_timeLeft.inMinutes % 60);
    final seconds = formatDigits(_timeLeft.inSeconds % 60);

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTimeBox(days, 'Èk'),
          const SizedBox(width: 8),
          const Text(':', style: TextStyle(fontSize: 28, color: AuruduTheme.gold, fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          _buildTimeBox(hours, 'meh'),
          const SizedBox(width: 8),
          const Text(':', style: TextStyle(fontSize: 28, color: AuruduTheme.gold, fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          _buildTimeBox(minutes, 'úkdä'),
          const SizedBox(width: 8),
          const Text(':', style: TextStyle(fontSize: 28, color: AuruduTheme.gold, fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          _buildTimeBox(seconds, ';;amr'),
        ],
      ),
    );
  }
}
