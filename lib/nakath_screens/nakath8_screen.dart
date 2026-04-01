import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/timer_display.dart';
import '../../widgets/rounded_white_button.dart';
import '../nakath_screens/nakath7_screen.dart';
import '../../app_theme.dart';

class Nakath8Screen extends StatelessWidget {
  const Nakath8Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: 'kele;a iSÜgqj 2026'),
      body: AuruduTheme.backgroundStack(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                const Text('/lSrlaId i|yd msg;aùu', style: AuruduTheme.titleGold),
                const SizedBox(height: 16),
                TimerDisplay(targetDateTime: DateTime(2026, 4, 17, 09, 03)),
                const SizedBox(height: 20),
                AuruduTheme.glassContainer(
                  opacity: 0.15,
                  child: const Text(
                    'wfm%a,a ui 17 jk n%yiam;skaod mQ¾jNd. 09\'03g rkajka  meye;s jia;%dNrKfhka ieriS lsß n;la yd t<lsß ñY% leú,s j¾.hla wkqNj lr W;=re ÈYdj n,d msg;aj hEu uekú\'',
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
                    child: Image.asset('assets/images/nakath8.png', height: 200, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'ie\'hq( by; ish¿ kele;a fõ,djka ms<sfh, lr we;af;a › ,xld iïu; Trf,daiq fõ,djg wkqj ixialD;sl lghq;= fomd¾;fïka;=fõ isxy, w¿;a wjqreÿ kele;a lñgqj úisks\'',
                  textAlign: TextAlign.center, style: AuruduTheme.captionGold,
                ),
                const SizedBox(height: 24),
                RoundedWhiteButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Nakath7Screen())),
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
