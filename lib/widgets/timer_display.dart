import 'package:flutter/material.dart';
import 'dart:async';

class TimerDisplay extends StatefulWidget {
  final DateTime targetDateTime;

  const TimerDisplay({
    super.key,
    required this.targetDateTime,
  });

  @override
  State<TimerDisplay> createState() => _TimerDisplayState();
}

class _TimerDisplayState extends State<TimerDisplay> {
  late Duration _timeLeft;
  late Timer _timer;

  String formatDigits(int n) => n.toString().padLeft(2, '0');

  @override
  void initState() {
    super.initState();
    _updateTimeLeft();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateTimeLeft();
    });
  }

  void _updateTimeLeft() {
    final now = DateTime.now();
    final diff = widget.targetDateTime.difference(now);

    setState(() {
      _timeLeft = diff.isNegative ? Duration.zero : diff;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = formatDigits(_timeLeft.inDays);
    final hours = formatDigits(_timeLeft.inHours % 24);
    final minutes = formatDigits(_timeLeft.inMinutes % 60);
    final seconds = formatDigits(_timeLeft.inSeconds % 60);

    return Column(
      children: [
        Text(
          '$days : $hours : $minutes : $seconds',
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xFFD4AF37),
            fontFamily: 'Gafata-Regular',
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          '    Èk      meh    úkdä   ;;amr',
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'TharuDigitalNikini',
            color: Color(0xFFD4AF37),
          ),
        ),
      ],
    );
  }
}
