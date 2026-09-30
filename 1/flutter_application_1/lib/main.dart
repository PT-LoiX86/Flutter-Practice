import 'package:flutter/material.dart';

import 'story.data.dart';

void main() {
  runApp(const Destini());
}

class Destini extends StatelessWidget {
  const Destini({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StoryPage(),
    );
  }
}

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  final StoryBrain _storyBrain = StoryBrain();

  void _choose(int choiceNumber) {
    setState(() {
      _storyBrain.nextStory(choiceNumber);
    });
  }

  Widget _buildChoiceButton({
    required String text,
    required Color color,
    required int choiceNumber,
  }) {
    return TextButton(
      onPressed: () => _choose(choiceNumber),
      style: TextButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 12,
                child: Center(
                  child: Text(
                    _storyBrain.story,
                    style: const TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),

              Expanded(
                flex: 2,
                child: _buildChoiceButton(
                  text: _storyBrain.choice1,
                  color: Colors.red,
                  choiceNumber: 1,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                flex: 2,
                child: Visibility(
                  visible: _storyBrain.hasChoice2,
                  child: _buildChoiceButton(
                    text: _storyBrain.choice2,
                    color: Colors.blue,
                    choiceNumber: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
