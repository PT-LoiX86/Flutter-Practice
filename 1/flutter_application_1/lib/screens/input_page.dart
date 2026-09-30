import 'package:flutter/material.dart';

import '../components/button.dart';
import '../components/gender_card.dart';
import '../components/number_adjuster_card.dart';
import '../components/common_card.dart';
import '../constants/app.dart';
import '../models/gender.dart';
import '../services/calculator.dart';
import 'result_page.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender? _selectedGender;

  int _height = 190;
  int _weight = 60;
  int _age = 30;

  void _selectGender(Gender gender) {
    setState(() {
      _selectedGender = gender;
    });
  }

  void _calculateBMI() {
    final calculator = CalculatorBrain(height: _height, weight: _weight);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsPage(
          bmiResult: calculator.bmi,
          resultText: calculator.result,
          interpretation: calculator.interpretation,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI CALCULATOR')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GenderCard(
                    gender: Gender.male,
                    selectedGender: _selectedGender,
                    icon: Icons.male,
                    label: 'MALE',
                    onTap: () => _selectGender(Gender.male),
                  ),
                ),
                Expanded(
                  child: GenderCard(
                    gender: Gender.female,
                    selectedGender: _selectedGender,
                    icon: Icons.female,
                    label: 'FEMALE',
                    onTap: () => _selectGender(Gender.female),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: CommonCard(
              color: AppColors.activeCard,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('HEIGHT', style: AppTextStyles.label),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text('$_height', style: AppTextStyles.number),
                      const Text('cm', style: AppTextStyles.label),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      inactiveTrackColor: AppColors.label,
                      activeTrackColor: Colors.white,
                      thumbColor: AppColors.accent,
                      overlayColor: AppColors.accent.withValues(alpha: 0.16),
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 15,
                      ),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 30,
                      ),
                    ),
                    child: Slider(
                      value: _height.toDouble(),
                      min: 120,
                      max: 220,
                      onChanged: (value) {
                        setState(() {
                          _height = value.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: NumberAdjusterCard(
                    label: 'WEIGHT',
                    value: _weight,
                    onDecrease: () {
                      setState(() {
                        _weight--;
                      });
                    },
                    onIncrease: () {
                      setState(() {
                        _weight++;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: NumberAdjusterCard(
                    label: 'AGE',
                    value: _age,
                    onDecrease: () {
                      setState(() {
                        _age--;
                      });
                    },
                    onIncrease: () {
                      setState(() {
                        _age++;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          Button(title: 'CALCULATE', onPressed: _calculateBMI),
        ],
      ),
    );
  }
}
