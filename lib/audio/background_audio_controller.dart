import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart';

/// Singleton controller for the background music loop.
class BackgroundAudioController {
  static final BackgroundAudioController _instance =
      BackgroundAudioController._internal();
  factory BackgroundAudioController() => _instance;
  BackgroundAudioController._internal();

  final AudioPlayer _player = AudioPlayer();
  final _source = AssetSource('audio/bgm.mp3');

  /// Observable mute state for UI binding.
  final ValueNotifier<bool> isMutedNotifier = ValueNotifier(false);

  bool _isInitialized = false;
  bool _isManuallyMuted = false;
  bool _isTemporarilyDisabled = false;
  bool _isPlaying = false;

  bool get isMuted => _isManuallyMuted;

  // ── Initialise & auto-play ──────────────────────────
  Future<void> init() async {
    if (_isInitialized) return;
    _isInitialized = true;

    try {
      await _player.setReleaseMode(ReleaseMode.loop);
      await _player.setVolume(0.35);
      await _player.play(_source);
      _isPlaying = true;
      debugPrint('BGM started');
    } catch (e) {
      debugPrint('BGM init error: $e');
      _isInitialized = false;
    }
  }

  // ── Resume playback ───────────────────────────────
  Future<void> _resume() async {
    if (!_isInitialized || _isManuallyMuted || _isTemporarilyDisabled) return;
    try {
      if (!_isPlaying) {
        await _player.resume();
        _isPlaying = true;
        debugPrint('BGM resumed');
      }
    } catch (e) {
      debugPrint('BGM resume error: $e');
      // Fallback: re-play from source
      try {
        await _player.play(_source);
        _isPlaying = true;
        debugPrint('BGM re-played from source');
      } catch (e2) {
        debugPrint('BGM re-play error: $e2');
      }
    }
  }

  // ── Pause playback ────────────────────────────────
  Future<void> _pause() async {
    if (_isPlaying) {
      await _player.pause();
      _isPlaying = false;
      debugPrint('BGM paused');
    }
  }

  // ── Mute toggle (user action) ──────────────────────
  void toggle() {
    _isManuallyMuted = !_isManuallyMuted;
    isMutedNotifier.value = _isManuallyMuted;
    debugPrint('BGM mute toggled: $_isManuallyMuted');

    if (_isManuallyMuted) {
      _pause();
    } else if (!_isTemporarilyDisabled) {
      _resume();
    }
  }

  // ── Temporary disable (while Geetha plays) ────────
  void disableTemporarily() {
    _isTemporarilyDisabled = true;
    _pause();
  }

  void enableTemporarily() {
    _isTemporarilyDisabled = false;
    if (!_isManuallyMuted) _resume();
  }

  // ── App lifecycle helpers ─────────────────────────
  void onAppPaused() => _pause();

  void onAppResumed() {
    if (!_isManuallyMuted && !_isTemporarilyDisabled) _resume();
  }
}
