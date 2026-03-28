import 'package:flutter/material.dart';
import '../audio/background_audio_controller.dart';
import '../app_theme.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isPlaying = BackgroundAudioController().isPlaying;

  void _toggleAudio() {
    BackgroundAudioController().toggle();
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: AuruduTheme.gold),
      title: Text(
        widget.title,
        style: const TextStyle(
          fontFamily: 'TharuDigitalNikini',
          fontSize: 22,
          color: AuruduTheme.gold,
          shadows: [
            Shadow(color: Colors.black54, blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            isPlaying ? Icons.volume_up_rounded : Icons.volume_off_rounded,
            color: AuruduTheme.gold,
          ),
          onPressed: _toggleAudio,
        ),
      ],
    );
  }
}
