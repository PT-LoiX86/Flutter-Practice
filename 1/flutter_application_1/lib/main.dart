import 'package:flutter/material.dart';

import 'question.data.dart';

void main() {
  runApp(const Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Icon> _scoreKeeper = [];

  int _questionNumber = 0;
  int _score = 0;

  void _checkAnswer(bool userAnswer) {
    final correctAnswer = questionBank[_questionNumber].questionAnswer;

    final isCorrect = userAnswer == correctAnswer;

    final isLastQuestion = _questionNumber == questionBank.length - 1;

    setState(() {
      if (isCorrect) {
        _score++;
      }

      _scoreKeeper.add(
        Icon(
          isCorrect ? Icons.check : Icons.close,
          color: isCorrect ? Colors.green : Colors.red,
        ),
      );

      if (!isLastQuestion) {
        _questionNumber++;
      }
    });

    if (isLastQuestion) {
      _showResult();
    }
  }

  void _showResult() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          score: _score,
          totalQuestions: questionBank.length,
          scoreKeeper: List.of(_scoreKeeper),
          onRetry: _restartQuiz,
        ),
      ),
    );
  }

  void _restartQuiz() {
    setState(() {
      _questionNumber = 0;
      _score = 0;
      _scoreKeeper.clear();
    });

    Navigator.pop(context);
  }

  Widget _buildAnswerButton({
    required String text,
    required Color color,
    required bool answer,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: TextButton(
          onPressed: () => _checkAnswer(answer),
          style: TextButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 5,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      questionBank[_questionNumber].questionText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
              ),

              _buildAnswerButton(
                text: 'Đúng',
                color: Colors.green,
                answer: true,
              ),

              _buildAnswerButton(text: 'Sai', color: Colors.red, answer: false),

              Row(children: _scoreKeeper),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final List<Icon> scoreKeeper;
  final VoidCallback onRetry;

  const ResultPage({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.scoreKeeper,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: const Text('Kết Quả', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey.shade800,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hoàn thành!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            Text(
              'Điểm số: $score / $totalQuestions',
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),

            const SizedBox(height: 20),

            const Text(
              'Kết quả các câu:',
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: scoreKeeper,
            ),

            const SizedBox(height: 50),

            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Làm Lại',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
