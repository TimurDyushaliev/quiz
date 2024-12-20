import 'package:just_audio/just_audio.dart';

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playAudio() async {
    await _audioPlayer.setLoopMode(LoopMode.one);
    await _audioPlayer.setAsset('assets/let_it_snow.mp3');
    await _audioPlayer.play();
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }
}
