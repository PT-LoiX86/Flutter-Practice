import 'package:flutter/material.dart';

import '../constants/app.dart';
import 'common_card.dart';
import 'icon_button.dart';

class NumberAdjusterCard extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  const NumberAdjusterCard({
    super.key,
    required this.label,
    required this.value,
    required this.onDecrease,
    required this.onIncrease,
  });

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      color: AppColors.activeCard,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: AppTextStyles.label),
          Text('$value', style: AppTextStyles.number),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundIconButton(icon: Icons.remove, onPressed: onDecrease),
              const SizedBox(width: 10),
              RoundIconButton(icon: Icons.add, onPressed: onIncrease),
            ],
          ),
        ],
      ),
    );
  }
}
