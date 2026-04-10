import 'package:flutter/material.dart';
import '../utils/page_transitions.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/timer_display.dart';
import '../data/nakath_data.dart';
import '../screens/compass_details_screen.dart';
import '../screens/nakath_screen.dart';
import '../screens/about_us_screen.dart';
import '../screens/aurudu_geetha_screen.dart';
import '../app_theme.dart';

// Import all Nakath screens
import '../nakath_screens/nakath1_screen.dart';
import '../nakath_screens/nakath2_screen.dart';
import '../nakath_screens/nakath3_screen.dart';
import '../nakath_screens/nakath4_screen.dart';
import '../nakath_screens/nakath5_screen.dart';
import '../nakath_screens/nakath6_screen.dart';
import '../nakath_screens/nakath7_screen.dart';
import '../nakath_screens/nakath8_screen.dart';
import '../nakath_screens/nakath9_screen.dart';

// Helper function to get screen by title
Widget? getNakathScreenByTitle(String title) {
  switch (title) {
    case 'kj i| ne,Su':
      return const Nakath1Screen();
    case 'mrK wjqreoao i|yd iakdkh':
      return const Nakath2Screen();
    case 'w¨;a wjqreÿ Wodj':
      return const Nakath3Screen();
    case 'mqKH ld,h':
      return const Nakath4Screen();
    case 'wdydr msiSu':
      return const Nakath5Screen();
    case 'jev we,a,Su" .kqfokq lsÍu d wdydr wkqNjh':
      return const Nakath6Screen();
    case 'ysi f;,a .Eu':
      return const Nakath7Screen();
    case 'kj kele;':
      return const Nakath8Screen();
    case '/lSrlaId i|yd msg;aùu':
      return const Nakath9Screen();
    default:
      return null;
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String formatDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuruduTheme.darkBg,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: AuruduTheme.backgroundStack(
        child: SafeArea(
          child: Column(
            children: [
              const CustomAppBar(title: 'kele;a iSÜgqj 2026'),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ─── Section title ───
                      ShaderMask(
                        shaderCallback: (bounds) =>
                            AuruduTheme.goldShimmer.createShader(bounds),
                        child: const Text(
                          'ó,Õ kel;',
                          style: TextStyle(
                            fontSize: 28,
                            fontFamily: 'TharuDigitalNikini',
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // ─── Timer Card (Hero) ───
                      _buildTimerCard(),
                      const SizedBox(height: 12),

                      // ─── Navigation Cards ───
                      _buildNavCard(
                        icon: Icons.auto_stories_rounded,
                        title: 'kele;a iSÜgqj 2026',
                        imagePath: 'assets/images/couple.png',
                        onTap: () => _navigateTo(const NakathScreen()),
                      ),
                      _buildNavCard(
                        icon: Icons.explore_rounded,
                        title: 'ÈYdj n,d .kak\'',
                        imagePath: 'assets/images/compass.png',
                        onTap: () => _navigateTo(const CompassDetailsScreen()),
                      ),
                      _buildNavCard(
                        icon: Icons.music_note_rounded,
                        title: 'wjqreÿ .S;',
                        imagePath: 'assets/images/music.png',
                        onTap: () => _navigateTo(const AuruduGeethaScreen()),
                      ),
                      _buildNavCard(
                        icon: Icons.lightbulb_rounded,
                        title: 'woyia yd fhdackd',
                        imagePath: 'assets/images/idea.png',
                        onTap: () => _navigateTo(const AboutUsScreen()),
                      ),

                      const SizedBox(height: 24),

                      // ─── Festive greeting ───
                      ShaderMask(
                        shaderCallback: (bounds) =>
                            AuruduTheme.goldShimmer.createShader(bounds),
                        child: const Text(
                          'iqn w¨;a wjqreoaola fõjd æ',
                          style: TextStyle(
                            fontSize: 26,
                            fontFamily: 'TharuDigitalNikini',
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ─── Developer footer ───
                      _buildFooter(),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateTo(Widget screen) {
    Navigator.push(context, smoothPageRoute(screen));
  }

  Widget _buildTimerCard() {
    return InkWell(
      onTap: () {
        final now = DateTime.now();
        final nextNakath = nakathEvents
            .where((e) => e.dateTime.isAfter(now))
            .toList()
          ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
        final upcoming = nextNakath.isNotEmpty ? nextNakath.first : null;
        final screen =
            upcoming != null ? getNakathScreenByTitle(upcoming.title) : null;
        if (screen != null) _navigateTo(screen);
      },
      borderRadius: BorderRadius.circular(24),
      child: AuruduTheme.glassContainer(
        opacity: 0.15,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Builder(
                builder: (context) {
                  final now = DateTime.now();
                  final nextNakath = nakathEvents
                      .where((e) => e.dateTime.isAfter(now))
                      .toList()
                    ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
                  final upcoming =
                      nextNakath.isNotEmpty ? nextNakath.first : null;

                  return Column(
                    children: [
                      Text(
                        upcoming?.title ?? 'නව නැකත් සිදුවීමක් නැත',
                        style: AuruduTheme.subtitleGold,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      if (upcoming != null)
                        TimerDisplay(
                          key: ValueKey(upcoming.dateTime),
                          targetDateTime: upcoming.dateTime,
                          onComplete: () => setState(() {}),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavCard({
    required IconData icon,
    required String title,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: AuruduTheme.glassContainer(
          opacity: 0.12,
          radius: 20,
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AuruduTheme.gold.withAlpha((0.15 * 255).toInt()),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AuruduTheme.gold.withAlpha((0.3 * 255).toInt()),
                  ),
                ),
                child: Icon(icon, color: AuruduTheme.gold, size: 26),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'TharuDigitalNikini',
                    color: AuruduTheme.warmWhite,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AuruduTheme.gold.withAlpha((0.6 * 255).toInt()),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Image.asset('assets/images/nd_logo.png', height: 50),
        const SizedBox(height: 8),
        const Text(
          'Developed by: Nadun Daluwatta',
          textAlign: TextAlign.center,
          style: AuruduTheme.footerText,
        ),
        const Text(
          'nsaluwatta@gmail.com',
          style: AuruduTheme.footerText,
        ),
        const Text(
          'www.nadun.live',
          style: AuruduTheme.footerText,
        ),
      ],
    );
  }
}
