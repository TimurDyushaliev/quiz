import 'dart:async';

abstract final class ScoreStorage {
  static final _streamController = StreamController<int>();

  static Stream<int> stream = _streamController.stream;

  static int _score = 0;

  static void add(int score) {
    _score += score;
    _streamController.add(_score);
  }
}
