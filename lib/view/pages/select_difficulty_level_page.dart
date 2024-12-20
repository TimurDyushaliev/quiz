import 'package:flutter/material.dart';
import 'package:quiz/data/score_storage.dart';
import 'package:quiz/view/pages/select_topic_page.dart';
import 'package:quiz/view/widgets/background_scaffold.dart';

class SelectDifficultyLevelPage extends StatefulWidget {
  const SelectDifficultyLevelPage({super.key});

  @override
  State<SelectDifficultyLevelPage> createState() =>
      _SelectDifficultyLevelPageState();
}

class _SelectDifficultyLevelPageState extends State<SelectDifficultyLevelPage> {
  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: StreamBuilder<int>(
                initialData: 0,
                stream: ScoreStorage.stream,
                builder: (context, snapshot) {
                  return Text(
                    'Total score: ${snapshot.data}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  );
                }),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select difficulty',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
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
                        builder: (_) => SelectTopicPage(
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
