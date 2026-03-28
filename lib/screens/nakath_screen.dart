import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../nakath_screens/nakath1_screen.dart';
import '../nakath_screens/nakath2_screen.dart';
import '../nakath_screens/nakath3_screen.dart';
import '../nakath_screens/nakath4_screen.dart';
import '../nakath_screens/nakath5_screen.dart';
import '../nakath_screens/nakath6_screen.dart';
import '../nakath_screens/nakath7_screen.dart';
import '../nakath_screens/nakath8_screen.dart';
import '../app_theme.dart';

class NakathScreen extends StatelessWidget {
  const NakathScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> nakathItems = [
      {'title': 'kj i| ne,Su', 'image': 'assets/images/nakath1.png', 'screen': const Nakath1Screen()},
      {'title': 'mrK wjqreoao i|yd iakdkh', 'image': 'assets/images/nakath2.png', 'screen': const Nakath2Screen()},
      {'title': 'w¨;a wjqreÿ Wodj', 'image': 'assets/images/nakath3.png', 'screen': const Nakath3Screen()},
      {'title': 'mqKH ld,h', 'image': 'assets/images/nakath4.png', 'screen': const Nakath4Screen()},
      {'title': 'wdydr msiSu', 'image': 'assets/images/nakath5.png', 'screen': const Nakath5Screen()},
      {'title': 'jev we,a,Su" .kqfokq lsÍu yd wdydr wkqNjh', 'image': 'assets/images/nakath6.png', 'screen': const Nakath6Screen()},
      {'title': 'ysi f;,a .Eu', 'image': 'assets/images/nakath7.png', 'screen': const Nakath7Screen()},
      {'title': '/lSrlaId i|yd msg;aùu', 'image': 'assets/images/nakath8.png', 'screen': const Nakath8Screen()},
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: 'kele;a iSÜgqj 2025'),
      body: AuruduTheme.backgroundStack(
        child: SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: nakathItems.length,
            itemBuilder: (context, index) {
              final item = nakathItems[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => item['screen'])),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    decoration: AuruduTheme.glassCard(opacity: 0.12, radius: 20),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: AuruduTheme.gold.withAlpha((0.4 * 255).toInt()),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(item['image'], height: 55, width: 55, fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            item['title'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 17,
                              color: AuruduTheme.warmWhite,
                              fontFamily: 'TharuDigitalNikini',
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AuruduTheme.gold.withAlpha((0.6 * 255).toInt()),
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
