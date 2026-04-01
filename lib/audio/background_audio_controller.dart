import 'package:audioplayers/audioplayers.dart';

class BackgroundAudioController {
  static final BackgroundAudioController _instance = BackgroundAudioController._internal();
  factory BackgroundAudioController() => _instance;

  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  bool _isManuallyMuted = false; // ✅ New flag

  BackgroundAudioController._internal();

  bool get isPlaying => _isPlaying;
  bool get isMuted => _isManuallyMuted;

  Future<void> init() async {
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.setSource(AssetSource('audio/bgm.mp3'));
    play();
  }

  void play() {
    if (!_isManuallyMuted) {
      _player.resume();
      _isPlaying = true;
    }
  }

  void pause() {
    _player.pause();
    _isPlaying = false;
  }

  void toggle() {
    if (_isPlaying) {
      pause();
      _isManuallyMuted = true;
    } else {
      _isManuallyMuted = false;
      play();
    }
  }

  void forcePause() {
    _player.pause();
    _isPlaying = false;
  }

  void autoResume() {
    if (!_isManuallyMuted) {
      play();
    }
  }
}

