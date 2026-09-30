import 'package:flutter/material.dart';

import '../constants/app.dart';

class IconLabel extends StatelessWidget {
  final IconData icon;
  final String label;

  const IconLabel({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 80),
        const SizedBox(height: 15),
        Text(label, style: AppTextStyles.label),
      ],
    );
  }
}
