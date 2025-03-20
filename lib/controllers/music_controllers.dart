import 'package:ball_run/utils/audios.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MusicControllers {
  late final SharedPreferences _pref;
  bool isPlaying = true;

  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();

    // Preload background music and sound effects
    await FlameAudio.audioCache.loadAll([
      Audios.score,
      Audios.tap,
      Audios.lose,
      Audios.jump,
    ]);

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
    FlameAudio.bgm.play(Audios.backgroundMusic, volume: 0.03);
    await _pref.setBool('isMusicPlaying', true);
  }

  Future<void> stopMusic() async {
    print('stop music');
    FlameAudio.bgm.stop();
    await _pref.setBool('isMusicPlaying', false);
  }

  Future<void> _playSoundEffect(String soundFile, {double volume = 0.5}) async {
    FlameAudio.play(soundFile, volume: volume);
  }

  Future<void> playScoreMusic() async => _playSoundEffect(Audios.score);
  Future<void> playTapMusic() async => _playSoundEffect(Audios.tap);
  Future<void> playLoseMusic() async => _playSoundEffect(Audios.lose);
  Future<void> playJumpMusic() async => _playSoundEffect(Audios.jump);
}