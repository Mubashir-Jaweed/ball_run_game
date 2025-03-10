import 'package:audioplayers/audioplayers.dart';
import 'package:ball_run/utils/audios.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MusicControllers {
  late final SharedPreferences _pref;

  bool isPlaying = true;
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
    isPlaying = _pref.getBool('isMusicPlaying') ?? true;

    if (isPlaying) {
      await playMusic();
    }
  }

  Future<void> toggleMusic() async {
    isPlaying = _pref.getBool('isMusicPlaying')!;
    isPlaying ? await stopMusic() : await playMusic();
  }

  Future<void> playMusic() async {
    print('play music');
    await _audioPlayer.play(AssetSource(Audios.backgroundMusic), volume: 0.03);
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
    _pref.setBool('isMusicPlaying', true);
  }

  Future<void> stopMusic() async {
    print('stop music');

    await _audioPlayer.stop();

    _pref.setBool('isMusicPlaying', false);
  }


  Future<void> _playSoundEffect(String soundFile) async {
    final AudioPlayer soundEffectPlayer = AudioPlayer();
    await soundEffectPlayer.play(AssetSource(soundFile));
  }

  Future<void> playScoreMusic() async {
   await _playSoundEffect(Audios.score);
  }
}
