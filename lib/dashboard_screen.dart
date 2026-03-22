import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/timer_display.dart';
import '../data/nakath_data.dart';
import '../screens/compass_details_screen.dart';
import '../screens/nakath_screen.dart';
import '../screens/about_us_screen.dart';
import '../screens/aurudu_geetha_screen.dart';

// Import all Nakath screens
import '../nakath_screens/nakath1_screen.dart';
import '../nakath_screens/nakath2_screen.dart';
import '../nakath_screens/nakath3_screen.dart';
import '../nakath_screens/nakath4_screen.dart';
import '../nakath_screens/nakath5_screen.dart';
import '../nakath_screens/nakath6_screen.dart';
import '../nakath_screens/nakath7_screen.dart';
import '../nakath_screens/nakath8_screen.dart';

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
    case '/lSrlaId i|yd msg;aùu':
      return const Nakath8Screen();
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
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const CustomAppBar(title: 'kele;a iSÜgqj 2025'),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'ó,Õ kel;',
                            style: TextStyle(
                              fontSize: 26,
                              fontFamily: 'TharuDigitalNikini',
                              color: Color(0xFFD4AF37), // Gold for background
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 5),

                        // Timer Card
                        InkWell(
                          onTap: () {
                            final now = DateTime.now();
                            final nextNakath = nakathEvents
                                .where((e) => e.dateTime.isAfter(now))
                                .toList()
                              ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
                            final upcoming = nextNakath.isNotEmpty ? nextNakath.first : null;

                            final screen = upcoming != null ? getNakathScreenByTitle(upcoming.title) : null;

                            if (screen != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => screen),
                              );
                            }
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: _buildCard(
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 12),
                                  Builder(
                                    builder: (context) {
                                      final now = DateTime.now();
                                      final nextNakath = nakathEvents
                                          .where((e) => e.dateTime.isAfter(now))
                                          .toList()
                                        ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
                                      final upcoming = nextNakath.isNotEmpty ? nextNakath.first : null;

                                      return Column(
                                        children: [
                                          Text(
                                             upcoming?.title ?? 'නව නකත් සිදුවීමක් නැත',
                                             style: const TextStyle(
                                               fontSize: 20,
                                               fontFamily: 'TharuDigitalNikini',
                                               color: Color(0xFF5C0000), // Deep maroon on card
                                             ),
                                             textAlign: TextAlign.center,
                                           ),
                                          const SizedBox(height: 12),
                                          if (upcoming != null)
                                            TimerDisplay(
                                              targetDateTime: upcoming.dateTime,
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Couple Card
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NakathScreen(),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: _buildCard(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/couple.png',
                                  height: 80,
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'kele;a iSÜgqj 2025',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xFF5C0000),
                                    fontFamily: 'TharuDigitalNikini',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Compass Card
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CompassDetailsScreen(),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: _buildCard(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/compass.png',
                                  width: 40,
                                  height: 40,
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'ÈYdj n,d .kak\'',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xFF5C0000),
                                    fontFamily: 'TharuDigitalNikini',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Aururdu Geetha Card
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AuruduGeethaScreen(),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: _buildCard(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/music.png',
                                  width: 40,
                                  height: 40,
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'wjqreÿ .S;',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xFF5C0000),
                                    fontFamily: 'TharuDigitalNikini',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // reviews screen
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AboutUsScreen(),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: _buildCard(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/idea.png',
                                  width: 40,
                                  height: 40,
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'woyia yd fhdackd',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xFF5C0000),
                                    fontFamily: 'TharuDigitalNikini',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Center(
                          child: Text(
                            'iqn w¨;a wjqreoaola fõjd æ',
                            style: TextStyle(
                              fontSize: 24,
                              color: Color(0xFFD4AF37), // Gold
                              fontFamily: 'TharuDigitalNikini',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/nd_logo.png',
                                height: 60,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Developed by:\nNadun Daluwatta',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                ),
                              ),
                              const Text(
                                'nadundaluwatta26@gmail.com',
                                style: TextStyle(color: Colors.white70),
                              ),
                              const Text(
                                'www.nadundaluwatta.me',
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF6E3).withAlpha((0.95 * 255).toInt()), // Parchment color with slight transparency
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD4AF37), width: 1.5), // Subtle gold border
        boxShadow: const [
          BoxShadow(color: Colors.black45, blurRadius: 8, offset: Offset(2, 6)), // Softer, deeper shadow
        ],
      ),
      child: child,
    );
  }
}
