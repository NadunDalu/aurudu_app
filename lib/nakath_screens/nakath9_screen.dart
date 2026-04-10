import 'package:flutter/material.dart';
import '../../utils/page_transitions.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/timer_display.dart';
import '../../widgets/rounded_white_button.dart';
import '../nakath_screens/nakath8_screen.dart';
import '../../app_theme.dart';
import '../../screens/nakath_screen.dart';

class Nakath9Screen extends StatelessWidget {
  const Nakath9Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, dynamic result) {
        if (didPop) return;
        Navigator.pushAndRemoveUntil(
          context,
          smoothFadeRoute(const NakathScreen()),
          (route) => route.isFirst,
        );
      },
      child: Scaffold(
      backgroundColor: AuruduTheme.darkBg,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: 'kele;a iSÜgqj 2026', onBackPressed: () => Navigator.pushAndRemoveUntil(context, smoothFadeRoute(const NakathScreen()), (route) => route.isFirst)),
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
                TimerDisplay(targetDateTime: DateTime(2026, 4, 10, 11, 30)),//rakiya sandaha pitathwayama
                const SizedBox(height: 20),
                AuruduTheme.glassContainer(
                  opacity: 0.15,
                  child: const Text(//rakiya sandaha pitathwayama
                    'wfm%a,a ui 20 jk i÷od mQ¾jNd. 06\'27 g Yafõ; j¾K jia;%dNrKfhka ieriS lsß n;la yd t<lsß ñY% leú,s j¾.hla wkqNj lr ol=Kq ÈYdj n,d msg;aj hEu uekú\'',
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
                    child: Image.asset('assets/images/nakath9.png', height: 200, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'ie\'hq( by; ish¿ kele;a fõ,djka ms<sfh, lr we;af;a › ,xld iïu; Trf,daiq fõ,djg wkqj ixialD;sl lghq;= fomd¾;fïka;=fõ isxy, w¿;a wjqreÿ kele;a lñgqj úisks\'',
                  textAlign: TextAlign.center, style: AuruduTheme.captionGold,
                ),
                const SizedBox(height: 24),
                RoundedWhiteButton(
                  onPressed: () => Navigator.push(context, smoothPageRoute(const Nakath8Screen())),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}
