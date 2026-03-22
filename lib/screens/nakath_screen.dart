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

class NakathScreen extends StatelessWidget {
  const NakathScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> nakathItems = [
      {
        'title': 'kj i| ne,Su',
        'image': 'assets/images/nakath1.png',
        'screen': const Nakath1Screen(),
      },
      {
        'title': 'mrK wjqreoao i|yd iakdkh',
        'image': 'assets/images/nakath2.png',
        'screen': const Nakath2Screen(),
      },
      {
        'title': 'w¨;a wjqreÿ Wodj',
        'image': 'assets/images/nakath3.png',
        'screen': const Nakath3Screen(),
      },
      {
        'title': 'mqKH ld,h',
        'image': 'assets/images/nakath4.png',
        'screen': const Nakath4Screen(),
      },
      {
        'title': 'wdydr msiSu',
        'image': 'assets/images/nakath5.png',
        'screen': const Nakath5Screen(),
      },
      {
        'title': 'jev we,a,Su" .kqfokq lsÍu yd wdydr wkqNjh',
        'image': 'assets/images/nakath6.png',
        'screen': const Nakath6Screen(),
      },
      {
        'title': 'ysi f;,a .Eu',
        'image': 'assets/images/nakath7.png',
        'screen': const Nakath7Screen(),
      },
      {
        'title': '/lSrlaId i|yd msg;aùu',
        'image': 'assets/images/nakath8.png',
        'screen': const Nakath8Screen(),
      },
    ];

    return Scaffold(
      appBar: const CustomAppBar(title: 'kele;a iSÜgqj 2025'),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: nakathItems.length,
          itemBuilder: (context, index) {
            final item = nakathItems[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => item['screen']),
                );
              },
              borderRadius: BorderRadius.circular(20),
              child: _buildCard(
                Row(
                  children: [
                    Image.asset(item['image'], height: 60, width: 60),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Center(
                        child: Text(
                          item['title'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color(0xFF5C0000),
                            fontFamily: 'TharuDigitalNikini',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
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
