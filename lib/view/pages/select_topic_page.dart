import 'package:flutter/material.dart';
import 'package:quiz/data/persistent_storage.dart';
import 'package:quiz/view/pages/quiz_page.dart';
import 'package:quiz/view/widgets/background_scaffold.dart';

class SelectTopicPage extends StatefulWidget {
  const SelectTopicPage({super.key, required this.difficultyLevel});

  final int difficultyLevel;

  @override
  State<SelectTopicPage> createState() => _SelectTopicPageState();
}

class _SelectTopicPageState extends State<SelectTopicPage> {
  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      appBar: AppBar(title: Text('${widget.difficultyLevel} Points Quiz')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select topic',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            ...List.generate(
              PersistentStorage.topics.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuizPage(
                          topicIndex: index,
                          difficultyLevel: widget.difficultyLevel,
                        ),
                      ),
                    );
                  },
                  child: Text(PersistentStorage.topics[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
