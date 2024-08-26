import 'package:flutter/material.dart';

import 'timer.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TimerCountdown(
          endTime: DateTime.now().add(Duration(minutes: 15)),
          format: CountDownTimerFormat.minutesSeconds,
        ),
      ),
    );
  }
}
