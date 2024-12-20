import 'dart:async';

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
  late Timer timer;
  late List<String> shuffledAnswers;

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
    _setTimer();
    shuffledAnswers = List.of(answers)..shuffle();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.difficultyLevel} Points Quiz'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: _getTimer(),
          )
        ],
      ),
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
              ...shuffledAnswers.map(
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

  void _setTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (mounted) setState(() {});
        if (timer.tick == 10) _checkAnswer(null);
      },
    );
  }

  void _checkAnswer(String? answer) {
    if (questionIndex < data.length - 1) {
      if (answer == answers[0]) {
        score += widget.difficultyLevel;
      }
      timer.cancel();
      _setTimer();
      setState(() {
        questionIndex++;
        question = data[questionIndex]['question'] as String;
        answers = data[questionIndex]['answers'] as List<String>;
        shuffledAnswers = List.of(answers)..shuffle();
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

  Widget _getTimer() {
    final tick = timer.tick;
    final text = tick == 0 ? '00:10' : '00:0${10 - tick}';

    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: tick > 6 ? Colors.red : null,
      ),
    );
  }
}
