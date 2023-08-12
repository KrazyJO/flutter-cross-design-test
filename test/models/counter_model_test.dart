import 'package:flutter_test/flutter_test.dart';
import 'package:runmate_flutter/models/counter_model.dart';

void main() {
  test('add steps to model', () {
    var model = CounterModel();

    var step1 = CounterStep(CounterStepType.prepare, 10);
    var step2 = CounterStep(CounterStepType.workout, 20);
    var step3 = CounterStep(CounterStepType.rest, 30);
    var step4 = CounterStep(CounterStepType.finish, 40);

    model.addStep(step1);
    model.addStep(step2);
    model.addStep(step3);
    model.addStep(step4);

    expect(model.stepsCount, 4);
    expect(model.nextStep, step1);
    expect(model.stepsCount, 3);
    expect(model.nextStep, step2);
    expect(model.stepsCount, 2);
    expect(model.nextStep, step3);
    expect(model.stepsCount, 1);
    expect(model.nextStep, step4);
    expect(model.stepsCount, 0);
  });
}