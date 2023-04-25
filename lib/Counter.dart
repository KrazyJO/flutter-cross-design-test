import 'dart:async';

import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  Timer? _timer;
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    startTimer();
    return Center(
      child: Column(
        children: [
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }

  void timerTick(Timer t) {
    setState(() {
      _counter++;
    });
  }

  void startTimer() {
    if (isTimerActive()) {
      return;
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      timerTick(t);
    });
  }

  bool isTimerActive() {
    return _timer != null && _timer!.isActive;
  }

  void stopTimer() {
    _timer?.cancel();
  }
}
