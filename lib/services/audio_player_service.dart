import 'package:just_audio/just_audio.dart';

final class AudioPlayerService {
  AudioPlayerService._();

  static final AudioPlayerService _instance = AudioPlayerService._();

  factory AudioPlayerService() => _instance;

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playAudio() async {
    if (_audioPlayer.playing) return;
    await _audioPlayer.setLoopMode(LoopMode.one);
    await _audioPlayer.setAsset('assets/let_it_snow.mp3');
    await _audioPlayer.play();
  }
}
