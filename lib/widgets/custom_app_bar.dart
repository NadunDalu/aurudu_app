import 'package:flutter/material.dart';
import '../audio/background_audio_controller.dart';

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
      title: Text(
        widget.title,
        style: const TextStyle(
          fontFamily: 'TharuDigitalNikini',
          fontSize: 22,
          color: Color(0xFFD4AF37),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            isPlaying ? Icons.volume_up : Icons.volume_off,
            color: const Color(0xFFD4AF37),
          ),
          onPressed: _toggleAudio,
        ),
      ],
    );
  }
}
