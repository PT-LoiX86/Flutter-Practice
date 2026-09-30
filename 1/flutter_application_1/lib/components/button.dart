import 'package:flutter/material.dart';

import '../constants/app.dart';

class Button extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const Button({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: AppDimensions.buttonHeight,
        margin: const EdgeInsets.only(top: 10),
        color: AppColors.accent,
        alignment: Alignment.center,
        child: Text(title, style: AppTextStyles.largeButton),
      ),
    );
  }
}
