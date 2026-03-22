import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//import 'package:youtube_player_flutter/src/widgets/progress_bar.dart';
import '../widgets/custom_app_bar.dart';
import '../audio/background_audio_controller.dart';

class AuruduGeethaScreen extends StatefulWidget {
  const AuruduGeethaScreen({super.key});

  @override
  State<AuruduGeethaScreen> createState() => _AuruduGeethaScreenState();
}

class _AuruduGeethaScreenState extends State<AuruduGeethaScreen> {
  final List<Map<String, String>> songs = [
    {
      'title': ';=ka fyf<a yev ^iQßh ux.,af,a&',
      'image': 'assets/images/music.png',
      'youtubeUrl': 'https://www.youtube.com/watch?v=0m4wIg7yZFo',
    },
    {
      'title': 'isß,l msß wjqreÿ isß',
      'image': 'assets/images/music.png',
      'youtubeUrl': 'https://www.youtube.com/watch?v=bBPkMCyaQ6s',
    },
    {
      'title': 'iqn isysfka hdù',
      'image': 'assets/images/music.png',
      'youtubeUrl': 'https://www.youtube.com/watch?v=RndUizJ0CrI',
    },
    {
      'title': 'wd, mqrkakg',
      'image': 'assets/images/music.png',
      'youtubeUrl': 'https://www.youtube.com/watch?v=Zs5fQqfJgKg',
    },
    {
      'title': 'ysre kef.kd',
      'image': 'assets/images/music.png',
      'youtubeUrl': 'https://www.youtube.com/watch?v=OwRTiov3lzs',
    },
    {
      'title': 'lsÑ ìÑhg ^rE jrekd&',
      'image': 'assets/images/music.png',
      'youtubeUrl': 'https://www.youtube.com/watch?v=0_nZrw6knWw',
    },
    {
      'title': 'rka mdáka fmfka È,S,d',
      'image': 'assets/images/music.png',
      'youtubeUrl': 'https://www.youtube.com/watch?v=lAMdd3pUhiM',
    },
    {
      'title': 'trnÿ u,a msms,d',
      'image': 'assets/images/music.png',
      'youtubeUrl': 'https://www.youtube.com/watch?v=ZNB9BaroSmU',
    },
    {
      'title': ',kafoa Wl=, Wv',
      'image': 'assets/images/music.png',
      'youtubeUrl': 'https://www.youtube.com/watch?v=Jo1fEs0EGzA',
    },
    {
      'title': 'rka oEle;af;ka',
      'image': 'assets/images/music.png',
      'youtubeUrl': 'https://www.youtube.com/watch?v=BZ4j4GXjezA',
    },
    {
      'title': 'fï wjqreÿ ldf,a',
      'image': 'assets/images/music.png',
      'youtubeUrl': 'https://www.youtube.com/watch?v=XXOQhGeKV-0',
    },
    {
      'title': 'fldfyda u,a jdrï',
      'image': 'assets/images/music.png',
      'youtubeUrl': 'https://www.youtube.com/watch?v=_LedoOR7Lbo',
    },
    {
      'title': 'fldfyda fldfyda',
      'image': 'assets/images/music.png',
      'youtubeUrl': 'https://www.youtube.com/watch?v=UEGZ85Uqh5I',
    },
    {
      'title': 'ó wU w;af;a',
      'image': 'assets/images/music.png',
      'youtubeUrl': 'https://www.youtube.com/watch?v=4HecCAJ0Egw',
    },
    {
      'title': 'kd~ka mqxÑ ysrufka',
      'image': 'assets/images/music.png',
      'youtubeUrl': 'https://www.youtube.com/watch?v=xqtqnygfCug',
    },
    {
      'title': 'neoao mqrd iqÿ froao jf.a',
      'image': 'assets/images/music.png',
      'youtubeUrl': 'https://www.youtube.com/watch?v=67eRHR6UZyo',
    },
    {
      'title': 'lkao Wäka y| mdhk ,S,d',
      'image': 'assets/images/music.png',
      'youtubeUrl': 'https://www.youtube.com/watch?v=phKp8TyIMGk',
    },
    {
      'title': 'mqxÑ me,;a fï ldf,a ud,s.d',
      'image': 'assets/images/music.png',
      'youtubeUrl': 'https://www.youtube.com/watch?v=lAcvdcmU2F4',
    },
    {
      'title': 'weú,a,d weú,a,d',
      'image': 'assets/images/music.png',
      'youtubeUrl': 'https://www.youtube.com/watch?v=LRKr6lIewGk',
    },
    {
      'title': 'wjqreÿ wdjd',
      'image': 'assets/images/music.png',
      'youtubeUrl': 'https://www.youtube.com/watch?v=LTuG2mEvcZs',
    },
  ];

  YoutubePlayerController? _playerController;
  int? _currentlyPlayingIndex;
  bool _isPlayerReady = false;

  void _togglePlay(int index) {
    final url = songs[index]['youtubeUrl']!;
    final videoId = YoutubePlayer.convertUrlToId(url);

    if (_currentlyPlayingIndex == index) {
      _playerController?.pause();
      BackgroundAudioController().autoResume();
      setState(() => _currentlyPlayingIndex = null);
    } else {
      _playerController?.pause();
      _playerController?.dispose();
      _playerController = null;
      BackgroundAudioController().pause();

      setState(() {
        _currentlyPlayingIndex = index;
        _isPlayerReady = false;
      });

      Future.delayed(const Duration(milliseconds: 100), () {
        final newController = YoutubePlayerController(
          initialVideoId: videoId!,
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
          ),
        );

        newController.addListener(() {
          if (newController.value.isReady && !_isPlayerReady) {
            setState(() => _isPlayerReady = true);
          }
        });

        setState(() {
          _playerController = newController;
        });
      });
    }
  }

  @override
  void dispose() {
    _playerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'wjqreÿ .S;'),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            if (_playerController != null && _currentlyPlayingIndex != null)
              Column(
                children: [
                  SizedBox(
                    height: 0,
                    width: 0,
                    child: YoutubePlayer(
                      controller: _playerController!,
                      onEnded: (meta) {
                        setState(() => _currentlyPlayingIndex = null);
                        BackgroundAudioController().play();
                      },
                    ),
                  ),
                  if (!_isPlayerReady)
                    const LinearProgressIndicator(
                      backgroundColor: Colors.white,
                      color: Color(0xFFD4AF37),
                      minHeight: 4,
                    ),
                ],
              ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  final song = songs[index];
                  final isPlaying = _currentlyPlayingIndex == index;
                  return InkWell(
                    onTap: () => _togglePlay(index),
                    borderRadius: BorderRadius.circular(20),
                    child: _buildCard(
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(song['image']!, height: 60, width: 60),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  song['title']!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF5C0000),
                                    fontFamily: 'TharuDigitalNikini',
                                  ),
                                ),
                              ),
                              Icon(
                                isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                                color: const Color(0xFF5C0000),
                                size: 30,
                              ),
                            ],
                          ),
                          if (isPlaying && _isPlayerReady)
                            ProgressBar(
                              controller: _playerController!,
                              colors: const ProgressBarColors(
                                playedColor: Color(0xFF5C0000),
                                handleColor: Color(0xFF5C0000),
                                bufferedColor: Colors.grey,
                                backgroundColor: Colors.black26,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF6E3).withAlpha((0.95 * 255).toInt()),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD4AF37), width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 8,
            offset: Offset(2, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}