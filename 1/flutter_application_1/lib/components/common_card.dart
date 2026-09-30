import 'package:flutter/material.dart';

import '../constants/app.dart';

class CommonCard extends StatelessWidget {
  final Color color;
  final Widget child;
  final VoidCallback? onTap;

  const CommonCard({
    super.key,
    required this.color,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(AppDimensions.cardMargin),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        ),
        child: child,
      ),
    );
  }
}
