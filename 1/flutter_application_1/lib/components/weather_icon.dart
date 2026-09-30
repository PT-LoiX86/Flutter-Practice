import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final int conditionId;

  const WeatherIcon({super.key, required this.conditionId});

  IconData get icon {
    if (conditionId >= 200 && conditionId < 300) {
      return Icons.thunderstorm;
    }

    if (conditionId >= 300 && conditionId < 600) {
      return Icons.water_drop;
    }

    if (conditionId >= 600 && conditionId < 700) {
      return Icons.ac_unit;
    }

    if (conditionId >= 700 && conditionId < 800) {
      return Icons.foggy;
    }

    if (conditionId == 800) {
      return Icons.wb_sunny;
    }

    if (conditionId > 800) {
      return Icons.cloud;
    }

    return Icons.cloud;
  }

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: 70, color: Colors.lightBlue);
  }
}
