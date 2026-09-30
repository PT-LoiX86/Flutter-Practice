import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF0A0E21);
  static const activeCard = Color(0xFF1D1E33);
  static const inactiveCard = Color(0xFF111328);
  static const accent = Color(0xFFEB1555);
  static const roundButton = Color(0xFF4C4F5E);

  static const label = Color(0xFF8D8E98);
  static const result = Color(0xFF24D876);

  static const male = Colors.blue;
  static const female = Colors.pink;
}

class AppDimensions {
  static const buttonHeight = 80.0;
  static const cardMargin = 15.0;
  static const cardRadius = 10.0;
}

class AppTextStyles {
  static const label = TextStyle(fontSize: 18, color: AppColors.label);

  static const number = TextStyle(fontSize: 50, fontWeight: FontWeight.w900);

  static const largeButton = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );

  static const title = TextStyle(fontSize: 50, fontWeight: FontWeight.bold);

  static const result = TextStyle(
    color: AppColors.result,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static const bmi = TextStyle(fontSize: 100, fontWeight: FontWeight.bold);

  static const body = TextStyle(fontSize: 22);
}
