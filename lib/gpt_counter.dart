import 'package:flutter/material.dart';
import 'package:runmate_flutter/models/counter_model.dart';
import 'dart:async';
import 'package:runmate_flutter/selection.dart';
import 'package:runmate_flutter/cross/ct_route.dart';
import 'package:runmate_flutter/widgets/indicator.dart';

class GPTCounter extends StatefulWidget {
  const GPTCounter({super.key});

  @override
  State<GPTCounter> createState() => _GPTCounterState();
}

class _GPTCounterState extends State<GPTCounter> with TickerProviderStateMixin {
  int _counter = 0;
  Timer? _timer;
  CounterModel? _steps;
  CounterStep? _currentStep;
  String _currentStepText = "NICHTS!!!!";
  late AnimationController controller;


  @override
  void initState() {
    super.initState();
    _timer = createTimer();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    createModel();
    nextStep();
    controller.forward();
  }

  void nextStep() {
    if (isFinished()) {
      end();
    } else {
      next();
    }
  }

  bool isFinished() {
    return _steps?.stepsCount == 0;
  }

  void next() {
    _currentStep = _steps?.nextStep;
    controller.duration = Duration(seconds: _currentStep!.duration);
    controller.reset();
    controller.forward();
    setState(() {
      _currentStepText = _currentStep!.typeText;
      _counter = _currentStep!.duration;
    });
  }

  void end() {
    _timer?.cancel();
    _currentStep = null;
    setState(() {
      _counter = 0;
    });
  }

  void createModel() {
    _steps = CounterModel();
    _steps!.addStep(CounterStep(CounterStepType.prepare, 10));
    _steps!.addStep(CounterStep(CounterStepType.workout, 15));
    _steps!.addStep(CounterStep(CounterStepType.rest, 20));
    _steps!.addStep(CounterStep(CounterStepType.workout, 15));
    _steps!.addStep(CounterStep(CounterStepType.rest, 20));
    _steps!.addStep(CounterStep(CounterStepType.finish, 5));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _decrementCounter() {
    if (_counter == 0) {
      nextStep();
    } else {

      setState(() {
        _counter--;
      });
    }

  }

  void _togglePause() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
      controller.stop(canceled: false);
    } else {
      _timer = createTimer();
      controller.forward();
    }
    setState(() {}); // Force rebuild to update button color
  }

  Timer createTimer() {
    const duration = Duration(seconds: 1);
    final timer = Timer.periodic(duration, (_) => _decrementCounter());
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

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  calculateIndicatorValue() {
    if (_currentStep == null) {
      return 0;
    }
    return 1 - _counter / _currentStep!.duration;
  }

  Color calculateIndicatorColor() {
    if (_currentStep == null) {
      return Colors.white;
    }
    switch (_currentStep!.type) {
      case CounterStepType.prepare:
        return Colors.blue;
      case CounterStepType.workout:
        return Colors.green;
      case CounterStepType.rest:
        return Colors.red;
      case CounterStepType.finish:
        return Colors.yellow;
    }
  }

  Widget _body() {
    var indicatorColor = calculateIndicatorColor();

    var indicator = SizedBox(height: 120, width: 120,
        child: AnimatedBuilder(
            animation: controller,
            builder: (c, child) => CustomPaint(
              painter: Indicator(value: controller.value, color: indicatorColor),
            )
        )
    );

    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            indicator,
            Text(_currentStepText, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 32),
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
      ),
    );
  }

  void navToPage2() {
    Route route = CTRoute.build((context) => const Selection());
    Navigator.of(context).push(route);
  }

  Row _buttonsRow() {

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
        sizedBox,
        playPauseButton,
        sizedBox,
        resetButton,
      ],
    );
  }
}
