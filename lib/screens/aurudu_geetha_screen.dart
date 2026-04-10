import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';
import '../widgets/custom_app_bar.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../app_theme.dart';
import '../audio/background_audio_controller.dart';
import '../utils/network_utils.dart';

class AuruduGeethaScreen extends StatefulWidget {
  const AuruduGeethaScreen({super.key});

  @override
  State<AuruduGeethaScreen> createState() => _AuruduGeethaScreenState();
}

class _AuruduGeethaScreenState extends State<AuruduGeethaScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, String>> songs = [
    {
      'title': 'iqn isysfka hdù',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775124833/suba-sihine-yawi-nawa-awurudu-various-artists_j6lvt5.mp3',
    },
    {
      'title': 'iQßh ux.,af,a',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775125101/soorya-mangalye-rohana-beddage-ranwala-balakaya_jliorl.mp3',
    },
    {
      'title': 'wjqreÿ <Õdjqkd',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775125106/awurudu-langa-una-hr-jothipala_clcwbp.mp3',
    },
    {
      'title': 'ó wU w;af;a',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775125177/mee-amba-aththe-koho-koho-milton-mallawarachchi-neela-wickramasinghe_yt4mbs.mp3',
    },
    {
      'title': 'fldfyda u,ajdrï',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775125197/koho-mal-waram-hr-jothipala_qdbe2p.mp3',
    },
    {
      'title': 'wd, mqrkakg is;a fndauhs',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775125225/ala-purannata-soorya-mangalya-centigradz_ed1dpn.mp3',
    },
    {
      'title': 'ls;a;dfka lsk;af;a',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775125247/kiththane-kinaththe-ravana-awurudu-geetaya-yohan-bihendra-ranasinghe-malinda-wijekoon_h7qbff.mp3',
    },
    {
      'title': 'kj wjqreÿ od',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775125296/nawa-awurudu-da-hr-jothipala_ljvalf.mp3',
    },
    {
      'title': 'fï wjqreÿ ldf,a',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775125350/me-awurudu-kale-lionel-ranwala_jtdlwg.mp3',
    },
    {
      'title': 'weú,a,d weú,a,d',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775125355/awilla-awilla-sinhala-aurudda-avilla-ishaq-beig-latha-walpola_buvcvp.mp3',
    },
    {
      'title': ';=ka fy, ux.,af,a',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775125365/thun-hela-mangalle-jananath-warakagoda-sahan-ranwala-isuru-jayarathna_vryaeo.mp3',
    },
    {
      'title': 'fldfyda fldfyda',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775125798/koho-koho-kohe-indan-sanath-nandasiri-sujatha-aththanayaka_i91dos.mp3',
    },
    {
      'title': ';=ka fyf,a fyd|',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775125807/thun-hele-hada-sooriya-mangalle-rohana-beddage_tt1n0b.mp3',
    },
    {
      'title': 'fodf,diauyla .;ù hk fudfydf;a',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775125856/dolos-mahak-gathawe-yana-mohethe-bandula-wijeweera-rohana-beddage_cscryn.mp3',
    },
    {
      'title': 'kdvka mqxÑ ysrufKa',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775125867/nadan-punchi-hiramane-pradeepa-dharmadasa_vtax4d.mp3',
    },
    {
      'title': 'r;g rf;a u,a mSfok',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775125894/rathata-rathe-mal-peedena-priya-sooriyasena_vxwhoo.mp3',
    },
    {
      'title': 'yekao kghs l+r kghs',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775125914/handa-natai-kura-natai-madhawi-shilpadhipathi_lpgetj.mp3',
    },
    {
      'title': 'rd rd rd fndïìfha',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775125977/ra-ra-ra-bombiye-muwa-weyan-nangiye-sunil-edirisinghe_qjoxkj.mp3',
    },
    {
      'title': 'trnÿ u,a msms,d',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775125982/erabadu-mal-pipila-awrudu-rajiv-sebastian-nelu-adhikari_dhqcgb.mp3',
    },
    {
      'title': '§. fkd.sh mqxÑ kEfkd',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775126055/deega-nogiya-punchi-nano-nanda-malini_g1csws.mp3',
    },
    {
      'title': 'trnÿ u,a msmS,d .ï ueoafoa',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775126065/erabadu-mal-pipila-gam-madde-unknown_t2n6gy.mp3',
    },
    {
      'title': 'fldmr fldmr',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775126144/thana-thana-raumata-idagena-kopara-kopara-edward-jayakody_ceulja.mp3',
    },
    {
      'title': 'lkao Wäka y| mdhk ,S,d',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775126178/kanda-udin-handa-payana-leela-amitha-wedisinghe_x2zcvh.mp3',
    },
    {
      'title': 'mqxÑ me,;a fï ldf,a ud,s.d',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775126185/punchi-palath-me-kale-maliga-new-manjula-warnakulasuriya_y0ci2h.mp3',
    },
    {
      'title': 'lsß b;sfrajd kj jifra',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775126498/kiri-ithirewa-nawa-wasare-hr-jothipala_siew1z.mp3',
    },
    {
      'title': 'lcq jdfra',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775126541/kaju-ware-erabadu-yaye-lionel-ranwala_sui7nn.mp3',
    },
    {
      'title': 'rka oEle;af;ka',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775126639/ran-dakaththen-nelana-goyamen-centigradz_zxhos3.mp3',
    },
    {
      'title': 'wjd wjqreÿ foaù',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775126661/awa-awurudu-devi-hr-jothipala_yca2db.mp3',
    },
    {
      'title': 'ysre kef.kd rE ujkd',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775126670/hiru-nagena-ru-mawana-awurudu-centigradz_d8vkpx.mp3',
    },
    {
      'title': 'neoao mqrd iqÿ froao jf.hs',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775126734/badda-pura-sudu-redda-wage-amitha-wedisinghe-piyasiri-wijeratne_fwpydx.mp3',
    },
    {
      'title': 'je,a ó je,aj,',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775126742/wal-mee-wal-wala-mee-mal-pipila-charitha-priyadarshani-peiris-edward-jayakody_vv8nvz.mp3',
    },
    {
      'title': 'fodvï lmd,d',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775126773/sinhala-awurudu-awa-dodam-kapala-ambul-thanala-wd-amaradeva_cb6g3e.mp3',
    },
    {
      'title': 'isß,l msß wjqreÿ isß',
      'audioUrl': 'https://res.cloudinary.com/dlp5mppxx/video/upload/v1775126841/Sirilaka_Piri_Aurudu_Siri_Me_Awurudde_-_Rohana_Beddage_Theekshana_Shashika_Amal_Nelu_Romesh_Various_Artists_eyuyx0.mp3',
    },
  ];

  final AudioPlayer _player = AudioPlayer();
  int? _currentlyPlayingIndex;
  bool _isPaused = false;
  bool _isHandlingCompletion = false;

  // Position / Duration streams
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<Duration?>? _durationSub;
  StreamSubscription<PlayerState>? _stateSub;

  late AnimationController _pulseController;

  Uri _safeUri(String rawUrl) {
    final safe = rawUrl.replaceAll('&', '%26');
    return Uri.parse(safe);
  }

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    // Listen to position updates
    _positionSub = _player.positionStream.listen((pos) {
      if (mounted) setState(() => _position = pos);
    });

    // Listen to duration updates
    _durationSub = _player.durationStream.listen((dur) {
      if (mounted && dur != null) setState(() => _duration = dur);
    });

    // Listen to player state changes
    _stateSub = _player.playerStateStream.listen((state) {
      if (!mounted) return;

      if (state.processingState == ProcessingState.completed) {
        if (!_isHandlingCompletion) {
          _isHandlingCompletion = true;
          // Safely auto-play next song after a tiny delay
          Future.delayed(const Duration(milliseconds: 500), () async {
            if (mounted) await _playNext();
            _isHandlingCompletion = false;
          });
        }
      }

      setState(() {
        // Update pause state from player
        if (state.playing) {
          _isPaused = false;
        }
      });
    });
  }

  Future<void> _playSong(int index) async {
    final bool hasInternet = await InternetConnection().hasInternetAccess;
    if (!hasInternet) {
      if (!mounted) return;
      NetworkUtils.showNetworkErrorDialog(context);
      return;
    }

    // If tapping the same song that's playing, toggle pause
    if (_currentlyPlayingIndex == index) {
      if (_isPaused) {
        _player.play();
        setState(() => _isPaused = false);
      } else {
        _player.pause();
        setState(() => _isPaused = true);
      }
      return;
    }

    final audioUrl = songs[index]['audioUrl']!;

    await _player.stop();

    // Pause background music while a song plays
    BackgroundAudioController().disableTemporarily();

    if (mounted) {
      setState(() {
        _currentlyPlayingIndex = index;
        _isPaused = false;
        _position = Duration.zero;
        _duration = Duration.zero;
      });
    }

    try {
      debugPrint('Loading audio: $audioUrl');
      final uri = _safeUri(audioUrl);
      await _player.setAudioSource(AudioSource.uri(uri));
      await _player.play();

      if (mounted) {
        // State updates if needed after play begins
      }
    } catch (e) {
      debugPrint('Audio playback error: $e');
      // Only reset if another song hasn't already been selected
      if (mounted && _currentlyPlayingIndex == index) {
        setState(() {
          _currentlyPlayingIndex = null;
          _isPaused = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Audio failed to play. Please try again.\n$e',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            backgroundColor: AuruduTheme.festiveRed,
          ),
        );
      }
    }
  }

  void _togglePause() {
    if (_currentlyPlayingIndex == null) return;

    if (_isPaused) {
      _player.play();
      setState(() => _isPaused = false);
    } else {
      _player.pause();
      setState(() => _isPaused = true);
    }
  }

  void _stopSong() async {
    await _player.stop();
    // Resume background music
    BackgroundAudioController().enableTemporarily();
    if (mounted) {
      setState(() {
        _currentlyPlayingIndex = null;
        _isPaused = false;
        _position = Duration.zero;
        _duration = Duration.zero;
      });
    }
  }

  Future<void> _playNext() async {
    if (_currentlyPlayingIndex == null) return;
    final nextIndex = (_currentlyPlayingIndex! + 1) % songs.length;
    await _playSong(nextIndex);
  }

  Future<void> _playPrevious() async {
    if (_currentlyPlayingIndex == null) return;
    // If more than 3 seconds in, restart current song
    if (_position.inSeconds > 3) {
      await _player.seek(Duration.zero);
      return;
    }
    final prevIndex = (_currentlyPlayingIndex! - 1 + songs.length) % songs.length;
    await _playSong(prevIndex);
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _positionSub?.cancel();
    _durationSub?.cancel();
    _stateSub?.cancel();
    _pulseController.dispose();
    _player.dispose();
    // Resume background music when leaving this screen
    BackgroundAudioController().enableTemporarily();
    super.dispose();
  }

  // ─── NOW PLAYING PANEL (bottom sheet style) ───
  Widget _buildNowPlayingPanel() {
    if (_currentlyPlayingIndex == null) return const SizedBox.shrink();

    final songTitle = songs[_currentlyPlayingIndex!]['title']!;
    final progress = _duration.inMilliseconds > 0
        ? (_position.inMilliseconds / _duration.inMilliseconds).clamp(0.0, 1.0)
        : 0.0;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      color: AuruduTheme.darkBg,
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Container(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      decoration: BoxDecoration(
        color: AuruduTheme.darkBg.withAlpha(240),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AuruduTheme.gold.withAlpha(80),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AuruduTheme.gold.withAlpha(30),
            blurRadius: 24,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.black.withAlpha(150),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Song info ──
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 8),
            child: Row(
              children: [
                // Album art / icon with playing pulse
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    final isActive = !_isPaused && _currentlyPlayingIndex != null;
                    final scale = isActive
                        ? 1.0 + (_pulseController.value * 0.06)
                        : 1.0;
                    return Transform.scale(
                      scale: scale,
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [
                              AuruduTheme.warmSaffron,
                              AuruduTheme.festiveRed,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(
                            color: AuruduTheme.gold.withAlpha(150),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AuruduTheme.festiveRed.withAlpha(
                                  isActive ? 120 : 60),
                              blurRadius: isActive ? 16 : 8,
                              spreadRadius: isActive ? 2 : 0,
                            ),
                          ],
                        ),
                        child: const Icon(
                                Icons.music_note_rounded,
                                color: AuruduTheme.gold,
                                size: 26,
                              ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 14),
                // Title + status
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        songTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          color: AuruduTheme.gold,
                          fontFamily: 'TharuDigitalNikini',
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        _isPaused ? 'Paused' : 'Now Playing',
                        style: TextStyle(
                          fontSize: 12,
                          color: _isPaused
                              ? AuruduTheme.warmWhite.withAlpha(120)
                              : AuruduTheme.lightGold.withAlpha(200),
                          fontFamily: 'Gafata-Regular',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                // Close / Stop button
                GestureDetector(
                  onTap: _stopSong,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withAlpha(15),
                      border: Border.all(
                        color: AuruduTheme.gold.withAlpha(60),
                      ),
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      color: AuruduTheme.warmWhite.withAlpha(180),
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Progress bar ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 4,
                      activeTrackColor: AuruduTheme.gold,
                      inactiveTrackColor: AuruduTheme.gold.withAlpha(40),
                      thumbColor: AuruduTheme.lightGold,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 7,
                      ),
                      overlayColor: AuruduTheme.gold.withAlpha(30),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 16,
                      ),
                    ),
                    child: Slider(
                      value: progress,
                      onChanged: (value) {
                        if (_duration.inMilliseconds > 0) {
                          final newPos = Duration(
                            milliseconds:
                                (value * _duration.inMilliseconds).round(),
                          );
                          _player.seek(newPos);
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(_position),
                          style: TextStyle(
                            fontSize: 12,
                            color: AuruduTheme.warmWhite.withAlpha(150),
                            fontFamily: 'Gafata-Regular',
                          ),
                        ),
                        Text(
                          _formatDuration(_duration),
                          style: TextStyle(
                            fontSize: 12,
                            color: AuruduTheme.warmWhite.withAlpha(150),
                            fontFamily: 'Gafata-Regular',
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // ── Playback Controls ──
          Padding(
            padding: const EdgeInsets.only(bottom: 14, top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Previous
                _buildControlButton(
                  icon: Icons.skip_previous_rounded,
                  size: 28,
                  buttonSize: 44,
                  onTap: _playPrevious,
                ),
                const SizedBox(width: 16),
                // Play / Pause (main button)
                _buildPlayPauseButton(),
                const SizedBox(width: 16),
                // Next
                _buildControlButton(
                  icon: Icons.skip_next_rounded,
                  size: 28,
                  buttonSize: 44,
                  onTap: _playNext,
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildPlayPauseButton() {
    return GestureDetector(
      onTap: _togglePause,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 62,
        height: 62,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [AuruduTheme.gold, AuruduTheme.warmSaffron],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AuruduTheme.gold.withAlpha(120),
              blurRadius: 16,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(
                _isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded,
                color: AuruduTheme.darkBg,
                size: 34,
              ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required double size,
    required double buttonSize,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withAlpha(15),
          border: Border.all(color: AuruduTheme.gold.withAlpha(60)),
        ),
        child: Icon(icon, color: AuruduTheme.warmWhite, size: size),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuruduTheme.darkBg,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: 'wjqreÿ .S;'),
      body: AuruduTheme.backgroundStack(
        child: SafeArea(
          child: Column(
            children: [
              // ─── Song List ───
              Expanded(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // Header (only when nothing is playing)
                    if (_currentlyPlayingIndex == null)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 30),
                          child: Column(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AuruduTheme.gold, width: 2),
                                  gradient: const RadialGradient(
                                    colors: [
                                      AuruduTheme.lightGold,
                                      AuruduTheme.festiveRed,
                                      AuruduTheme.darkBg,
                                    ],
                                    stops: [0.1, 0.5, 1.0],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          AuruduTheme.festiveRed.withAlpha(120),
                                      blurRadius: 30,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.music_note_rounded,
                                  color: AuruduTheme.darkBg,
                                  size: 50,
                                ),
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                'wjqreÿ .S; tl;=j',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontFamily: 'TharuDigitalNikini',
                                  color: AuruduTheme.gold,
                                  letterSpacing: 1.5,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black87,
                                      blurRadius: 10,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 8),
                                decoration: BoxDecoration(
                                  color: AuruduTheme.darkBg.withAlpha(150),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AuruduTheme.gold.withAlpha(80),
                                  ),
                                ),
                                child: Text(
                                  '${songs.length} Tracks Available',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AuruduTheme.warmWhite,
                                    fontFamily: 'Gafata-Regular',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    // Song list items
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate:
                            SliverChildBuilderDelegate((context, index) {
                          final song = songs[index];
                          final isPlaying = _currentlyPlayingIndex == index;
                          final isThisPaused = isPlaying && _isPaused;

                          return GestureDetector(
                            onTap: () => _playSong(index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOutCubic,
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                              decoration: BoxDecoration(
                                color: AuruduTheme.cream
                                    .withAlpha(isPlaying ? 35 : 12),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isPlaying
                                      ? AuruduTheme.lightGold
                                      : AuruduTheme.gold.withAlpha(40),
                                  width: isPlaying ? 1.5 : 1,
                                ),
                                boxShadow: [
                                  if (isPlaying)
                                    BoxShadow(
                                      color: AuruduTheme.gold.withAlpha(60),
                                      blurRadius: 20,
                                      spreadRadius: 1,
                                    ),
                                  BoxShadow(
                                    color: Colors.black.withAlpha(40),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  // Track number / playing indicator
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: isPlaying
                                          ? const LinearGradient(
                                              colors: [
                                                AuruduTheme.warmSaffron,
                                                AuruduTheme.festiveRed,
                                              ],
                                            )
                                          : null,
                                      color: isPlaying
                                          ? null
                                          : AuruduTheme.darkBg.withAlpha(120),
                                      border: Border.all(
                                        color: isPlaying
                                            ? AuruduTheme.lightGold
                                            : AuruduTheme.gold.withAlpha(60),
                                      ),
                                    ),
                                    child: Center(
                                      child: isPlaying
                                              ? Icon(
                                                  isThisPaused
                                                      ? Icons.pause_rounded
                                                      : Icons
                                                          .graphic_eq_rounded,
                                                  color: AuruduTheme.gold,
                                                  size: 22,
                                                )
                                              : Text(
                                                  '${index + 1}',
                                                  style: const TextStyle(
                                                    color: AuruduTheme.gold,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        'Gafata-Regular',
                                                  ),
                                                ),
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  // Song title + subtitle
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          song['title']!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: isPlaying ? 18 : 16,
                                            color: isPlaying
                                                ? AuruduTheme.gold
                                                : AuruduTheme.warmWhite,
                                            fontFamily: 'TharuDigitalNikini',
                                          ),
                                        ),
                                        if (isPlaying)
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 3),
                                            child: Text(
                                              isThisPaused
                                                      ? 'Paused'
                                                      : 'Playing',
                                              style: TextStyle(
                                                color: AuruduTheme.lightGold
                                                    .withAlpha(180),
                                                fontSize: 11,
                                                fontFamily: 'Gafata-Regular',
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  // Play / Pause icon on right
                                  Container(
                                    width: 42,
                                    height: 42,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isPlaying
                                          ? AuruduTheme.gold
                                          : Colors.white.withAlpha(15),
                                      border: Border.all(
                                        color: AuruduTheme.gold
                                            .withAlpha(isPlaying ? 0 : 40),
                                      ),
                                      boxShadow: isPlaying
                                          ? [
                                              BoxShadow(
                                                color: AuruduTheme.gold
                                                    .withAlpha(80),
                                                blurRadius: 12,
                                              ),
                                            ]
                                          : null,
                                    ),
                                    child: Icon(
                                      isPlaying
                                          ? (isThisPaused
                                              ? Icons.play_arrow_rounded
                                              : Icons.pause_rounded)
                                          : Icons.play_arrow_rounded,
                                      color: isPlaying
                                          ? AuruduTheme.darkBg
                                          : AuruduTheme.warmWhite,
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }, childCount: songs.length),
                      ),
                    ),
                    // Extra space at bottom for now-playing panel
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: _currentlyPlayingIndex != null ? 220 : 40,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // ── Bottom Now Playing Panel ──
      bottomNavigationBar: _currentlyPlayingIndex != null
          ? _buildNowPlayingPanel()
          : null,
    );
  }
}
