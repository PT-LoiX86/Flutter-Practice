import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const XylophoneApp());
}

class XylophoneApp extends StatefulWidget {
  const XylophoneApp({super.key});

  @override
  State<XylophoneApp> createState() => _XylophoneAppState();
}

class _XylophoneAppState extends State<XylophoneApp> {
  final AudioPlayer _player = AudioPlayer();

  Future<void> _playSound(int note) async {
    await _player.play(AssetSource('sounds/note$note.wav'));
  }

  Widget _buildKey({required Color color, required int note}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: TextButton(
          onPressed: () => _playSound(note),
          style: TextButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildKey(color: Colors.red, note: 1),
              _buildKey(color: Colors.orange, note: 2),
              _buildKey(color: Colors.yellow, note: 3),
              _buildKey(color: Colors.green, note: 4),
              _buildKey(color: Colors.teal, note: 5),
              _buildKey(color: Colors.blue, note: 6),
              _buildKey(color: Colors.purple, note: 7),
            ],
          ),
        ),
      ),
    );
  }
}
