import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/timer_display.dart';
import '../../widgets/rounded_red_button.dart';
import '../../widgets/rounded_white_button.dart';
import '../nakath_screens/nakath3_screen.dart';
import '../nakath_screens/nakath5_screen.dart';

class Nakath4Screen extends StatelessWidget {
  const Nakath4Screen({super.key});

  String formatDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const CustomAppBar(title: 'kele;a iSÜgqj 2025'),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),

              const Text(
                'mqKH ld,h',
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: 'TharuDigitalNikini',
                  color: Color(0xFFD4AF37),
                ),
              ),

              const SizedBox(height: 16),

              TimerDisplay(
                targetDateTime: DateTime(2025, 4, 13, 20, 57), // Apr 14, 2025 at 8:57 PM
              ),

              const SizedBox(height: 20),

              const Text(
                'wfm%a,a ui 13 jk bßod wmrNd. 08\'57 isg 14 jk i÷od mQ¾jNd. 09\'45 olajd mqKH ld,h neúka wfm%a,a ui 13 jk bßod wmrNd. 08\'57 g m<uqj wdydr mdk f.k ish¨ jev w;ayer wd.ñl j;dj;a j, fh§u o mqKH ld,fha wmr fldgi tkï wfm%a,a ui 14 jk i÷od mQ¾jNd. 03\'21 isg 14 jk i÷od mQ¾jNd. 09\'45 olajd my; oelafjk whqßka wdydr msiSu" jev we,a,Su" .Kqfokq lsÍu yd wdydr wkqNjh wd§ kele;a pdß;% úê bgq lsÍu uekú\'',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'FM_ARJUN',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/nakath4.png',
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'ie\'hq( by; ish¿ kele;a fõ,djka ms<sfh, lr we;af;a › ,xld iïu; Trf,daiq fõ,djg wkqj ixialD;sl lghq;= fomd¾;fïka;=fõ isxy, w¿;a wjqreÿ kele;a lñgqj úisks\'',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'TharuDigitalNikini',
                  color: Color(0xFFD4AF37),
                ),
              ),

              const SizedBox(height: 24),

              // White and Red buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedWhiteButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Nakath3Screen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  RoundedRedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  const Nakath5Screen(), //change this to the next screen
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
