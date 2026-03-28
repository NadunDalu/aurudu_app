import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/timer_display.dart';
import '../../widgets/rounded_red_button.dart';
import '../../widgets/rounded_white_button.dart';
import '../nakath_screens/nakath3_screen.dart';
import '../nakath_screens/nakath5_screen.dart';
import '../../app_theme.dart';

class Nakath4Screen extends StatelessWidget {
  const Nakath4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: 'kele;a iSÜgqj 2025'),
      body: AuruduTheme.backgroundStack(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                const Text('mqKH ld,h', style: AuruduTheme.titleGold),
                const SizedBox(height: 16),
                TimerDisplay(targetDateTime: DateTime(2025, 4, 13, 20, 57)),
                const SizedBox(height: 20),
                AuruduTheme.glassContainer(
                  opacity: 0.15,
                  child: const Text(
                    'wfm%a,a ui 13 jk bßod wmrNd. 08\'57 isg 14 jk i÷od mQ¾jNd. 09\'45 olajd mqKH ld,h neúka wfm%a,a ui 13 jk bßod wmrNd. 08\'57 g m<uqj wdydr mdk f.k ish¨ jev w;ayer wd.ñl j;dj;a j, fh§u o mqKH ld,fha wmr fldgi tkï wfm%a,a ui 14 jk i÷od mQ¾jNd. 03\'21 isg 14 jk i÷od mQ¾jNd. 09\'45 olajd my; oelafjk whqßka wdydr msiSu" jev we,a,Su" .Kqfokq lsÍu yd wdydr wkqNjh wd§ kele;a pdß;% úê bgq lsÍu uekú\'',
                    textAlign: TextAlign.center,
                    style: AuruduTheme.bodyWhite,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AuruduTheme.gold.withAlpha((0.4 * 255).toInt()), width: 1.5),
                    boxShadow: [BoxShadow(color: Colors.black.withAlpha((0.3 * 255).toInt()), blurRadius: 12, offset: const Offset(0, 4))],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset('assets/images/nakath4.png', height: 200, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'ie\'hq( by; ish¿ kele;a fõ,djka ms<sfh, lr we;af;a › ,xld iïu; Trf,daiq fõ,djg wkqj ixialD;sl lghq;= fomd¾;fïka;=fõ isxy, w¿;a wjqreÿ kele;a lñgqj úisks\'',
                  textAlign: TextAlign.center, style: AuruduTheme.captionGold,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedWhiteButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Nakath3Screen()))),
                    const SizedBox(width: 12),
                    RoundedRedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Nakath5Screen()))),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
