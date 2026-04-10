import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../audio/background_audio_controller.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;

  const CustomAppBar({super.key, required this.title, this.onBackPressed});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: widget.onBackPressed != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              color: AuruduTheme.gold,
              onPressed: widget.onBackPressed,
            )
          : null,
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
        ValueListenableBuilder<bool>(
          valueListenable: BackgroundAudioController().isMutedNotifier,
          builder: (context, isMuted, _) {
            return IconButton(
              icon: Icon(
                isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                color: AuruduTheme.gold,
              ),
              tooltip: isMuted ? 'Unmute' : 'Mute',
              onPressed: () => BackgroundAudioController().toggle(),
            );
          },
        ),
      ],
    );
  }
}
