import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz/data/persistent_storage.dart';
import 'package:quiz/data/score_storage.dart';
import 'package:quiz/view/widgets/background_scaffold.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({
    super.key,
    required this.topicIndex,
    required this.difficultyLevel,
  });

  final int topicIndex;
  final int difficultyLevel;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late String question;
  late List<String> answers;
  late Timer timer;
  late final List<String> shuffledAnswers;
  late List<Color> answerColors;

  @override
  void initState() {
    super.initState();

    final data = switch (widget.difficultyLevel) {
      10 => PersistentStorage.difficulty10[widget.topicIndex],
      20 => PersistentStorage.difficulty20[widget.topicIndex],
      30 => PersistentStorage.difficulty30[widget.topicIndex],
      40 => PersistentStorage.difficulty40[widget.topicIndex],
      50 => PersistentStorage.difficulty50[widget.topicIndex],
      _ => throw '',
    };
    question = data['question'] as String;
    answers = data['answers'] as List<String>;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (mounted) setState(() {});
        if (timer.tick == 20) _checkAnswer(null);
      },
    );
    shuffledAnswers = List.of(answers)..shuffle();
    answerColors = [];
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
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
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              ...List.generate(shuffledAnswers.length, (index) {
                final answer = shuffledAnswers[index];
                final color = answerColors.isEmpty ? null : answerColors[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: color),
                    onPressed: () => _checkAnswer(answer),
                    child: Text(answer),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _checkAnswer(String? answer) {
    if (answer == answers[0]) {
      ScoreStorage.add(widget.difficultyLevel);
    }

    setState(() {
      answerColors = shuffledAnswers
          .map((answer) => answer == answers[0] ? Colors.green : Colors.red)
          .toList();
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Navigator.pop(context);
    });
  }

  Widget _getTimer() {
    final tick = timer.tick;
    final text = '00:${(20 - tick).toString().padLeft(2, '0')}';

    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: tick > 14 ? Colors.red : null,
      ),
    );
  }
}
