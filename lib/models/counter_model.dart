class CounterModel {

    final List<CounterStep> _steps = [];

    CounterStep get nextStep {
        var step = _steps.removeAt(0);
        return step;
    }

    addStep(CounterStep step) {
        _steps.add(step);
    }

    int get stepsCount {
        return _steps.length;
    }
}

class CounterStep {
    final CounterStepType type;
    final int duration;

    CounterStep(this.type, this.duration);

    String get typeText {
        switch (type) {
            case CounterStepType.prepare:
                return "Prepare";
            case CounterStepType.workout:
                return "Workout";
            case CounterStepType.rest:
                return "Rest";
            case CounterStepType.finish:
                return "Finish";
            default:
                return "Unknown";
        }
    }
}

enum CounterStepType {
    prepare,
    workout,
    rest,
    finish
}