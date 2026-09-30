import 'package:flutter/material.dart';

import '../components/button.dart';
import '../components/common_card.dart';
import '../constants/app.dart';

class ResultsPage extends StatelessWidget {
  final String bmiResult;
  final String resultText;
  final String interpretation;

  const ResultsPage({
    super.key,
    required this.bmiResult,
    required this.resultText,
    required this.interpretation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI CALCULATOR RESULTS')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text('Your Result', style: AppTextStyles.title),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: CommonCard(
              color: AppColors.activeCard,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(resultText, style: AppTextStyles.result),
                  Text(bmiResult, style: AppTextStyles.bmi),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      interpretation,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Button(
            title: 'RE-CALCULATE',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
