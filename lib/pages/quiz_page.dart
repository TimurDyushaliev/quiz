import 'package:flutter/material.dart';
import 'package:quiz/data/storage.dart';
import 'package:quiz/pages/result_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.difficultyLevel});

  final int difficultyLevel;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late final List<Map<String, Object>> data;
  late String question;
  late List<String> answers;
  late int questionIndex;
  late int score;

  @override
  void initState() {
    super.initState();

    data = switch (widget.difficultyLevel) {
      10 => Storage.difficulty10,
      20 => Storage.difficulty20,
      30 => Storage.difficulty30,
      40 => Storage.difficulty40,
      50 => Storage.difficulty50,
      _ => throw '',
    };
    questionIndex = 0;
    question = data[questionIndex]['question'] as String;
    answers = data[questionIndex]['answers'] as List<String>;
    score = 0;
  }

  @override
  Widget build(BuildContext context) {
    final shuffled = List.of(answers)..shuffle();

    return Scaffold(
      appBar: AppBar(title: Text('${widget.difficultyLevel} Points Quiz')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                question,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 10),
              ...shuffled.map(
                (answer) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ElevatedButton(
                    onPressed: () => _checkAnswer(answer),
                    child: Text(answer),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _checkAnswer(String answer) {
    if (questionIndex < data.length - 1) {
      if (answer == answers[0]) {
        score += widget.difficultyLevel;
      }
      setState(() {
        questionIndex++;
        question = data[questionIndex]['question'] as String;
        answers = data[questionIndex]['answers'] as List<String>;
      });
    } else {
      if (answer == answers[0]) {
        score += widget.difficultyLevel;
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultPage(score: score),
        ),
      );
    }
  }
}
