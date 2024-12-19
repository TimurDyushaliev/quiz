import 'package:flutter/material.dart';
import 'package:quiz/pages/quiz_page.dart';

class SelectDifficultyLevelPage extends StatefulWidget {
  const SelectDifficultyLevelPage({super.key});

  @override
  State<SelectDifficultyLevelPage> createState() =>
      _SelectDifficultyLevelPageState();
}

class _SelectDifficultyLevelPageState extends State<SelectDifficultyLevelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select difficulty',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            ...List.generate(5, (index) {
              final difficultyLevel = (index + 1) * 10;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuizPage(
                          difficultyLevel: difficultyLevel,
                        ),
                      ),
                    );
                  },
                  child: Text('$difficultyLevel Points'),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
