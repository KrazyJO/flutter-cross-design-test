import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:runmate_flutter/Selection.dart';

class GPTCounter extends StatefulWidget {
  const GPTCounter({super.key});

  @override
  _GPTCounterState createState() => _GPTCounterState();
}

class _GPTCounterState extends State<GPTCounter> {
  int _counter = 0;
  Timer? _timer;
  bool _isCountingForward = true;

  @override
  void initState() {
    super.initState();
    _timer = createTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      if (_isCountingForward) {
        _counter++;
      } else {
        if (_counter > 0) {
          _counter--;
        }
      }
    });
  }

  void _togglePause() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    } else {
      _timer = createTimer();
    }
    setState(() {}); // Force rebuild to update button color
  }

  Timer createTimer() {
    const duration = Duration(milliseconds: 500);
    final timer = Timer.periodic(duration, (_) => _incrementCounter());
    return timer;
  }

  void _resetCounter() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }
    setState(() {
      _counter = 0;
    });
  }

  void _toggleDirection() {
    setState(() {
      _isCountingForward = !_isCountingForward;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Widget _body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$_counter',
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),
          _buttonsRow(),
          TextButton(
              onPressed: () => navToPage2(),
              child: const Text("nav to page 2")),
        ],
      ),
    );
  }

  void navToPage2() {
    Route route;
    if (Platform.isAndroid) {
      route = MaterialPageRoute(builder: (context) => const Selection());
    } else {
      route = CupertinoPageRoute(builder: (context) => const Selection());
    }
    Navigator.of(context).push(route);
  }

  Row _buttonsRow() {
    var upDownButton = FloatingActionButton(
      heroTag: "btn1",
      onPressed: _toggleDirection,
      child: Icon(
        _isCountingForward ? Icons.arrow_upward : Icons.arrow_downward,
      ),
    );

    var playPauseButton = FloatingActionButton(
      heroTag: "btn2",
      backgroundColor: _timer?.isActive == true ? Colors.green : Colors.yellow,
      onPressed: _togglePause,
      child: Icon(
        _timer?.isActive == true ? Icons.pause : Icons.play_arrow,
      ),
    );

    var resetButton = FloatingActionButton(
      heroTag: "btn3",
      onPressed: _resetCounter,
      child: const Icon(
        Icons.restart_alt,
      ),
    );

    var sizedBox = const SizedBox(width: 16);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        upDownButton,
        sizedBox,
        playPauseButton,
        sizedBox,
        resetButton,
      ],
    );
  }
}
