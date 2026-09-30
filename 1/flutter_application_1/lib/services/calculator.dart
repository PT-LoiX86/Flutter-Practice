import 'dart:math';

class CalculatorBrain {
  final int height;
  final int weight;

  const CalculatorBrain({required this.height, required this.weight});

  double get _bmi {
    return weight / pow(height / 100, 2);
  }

  String get bmi {
    return _bmi.toStringAsFixed(1);
  }

  String get result {
    if (_bmi >= 25) {
      return 'OVERWEIGHT';
    }

    if (_bmi > 18.5) {
      return 'NORMAL';
    }

    return 'UNDERWEIGHT';
  }

  String get interpretation {
    if (_bmi >= 25) {
      return 'You have a higher than normal body weight. '
          'Try to exercise more.';
    }

    if (_bmi > 18.5) {
      return 'You have a normal body weight. Good job!';
    }

    return 'You have a lower than normal body weight. '
        'You may want to eat a little more.';
  }
}
