import 'package:flutter/material.dart';

import '../constants/app.dart';
import '../models/gender.dart';
import 'icon_label.dart';
import 'common_card.dart';

class GenderCard extends StatelessWidget {
  final Gender gender;
  final Gender? selectedGender;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const GenderCard({
    super.key,
    required this.gender,
    required this.selectedGender,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = gender == selectedGender;

    Color color = AppColors.inactiveCard;

    if (isSelected) {
      color = gender == Gender.male ? AppColors.male : AppColors.female;
    }

    return CommonCard(
      color: color,
      onTap: onTap,
      child: IconLabel(icon: icon, label: label),
    );
  }
}
