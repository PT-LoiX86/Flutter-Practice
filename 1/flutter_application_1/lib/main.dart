import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const DiceApp());
}

class DiceApp extends StatelessWidget {
  const DiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dice',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const DicePage(),
    );
  }
}

class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  final Random _random = Random();

  int _leftDice = 1;
  int _rightDice = 1;

  void _rollDice() {
    setState(() {
      _leftDice = _random.nextInt(6) + 1;
      _rightDice = _random.nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dice'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(child: DiceImage(number: _leftDice)),
                Expanded(child: DiceImage(number: _rightDice)),
              ],
            ),

            const SizedBox(height: 50),

            ElevatedButton(
              onPressed: _rollDice,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Lắc xúc xắc'),
            ),
          ],
        ),
      ),
    );
  }
}

class DiceImage extends StatelessWidget {
  final int number;

  const DiceImage({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.asset(
          'assets/images/dice$number.jpg',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey.shade300,
              alignment: Alignment.center,
              child: const Text(
                'Image not found',
                style: TextStyle(color: Colors.red),
              ),
            );
          },
        ),
      ),
    );
  }
}
