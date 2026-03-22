import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/timer_display.dart';
import '../../widgets/rounded_white_button.dart';
import '../nakath_screens/nakath7_screen.dart';


class Nakath8Screen extends StatelessWidget {
  const Nakath8Screen({super.key});

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
                '/lSrlaId i|yd msg;aùu',
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: 'TharuDigitalNikini',
                  color: Color(0xFFD4AF37),
                ),
              ),

              const SizedBox(height: 16),

              TimerDisplay(
                targetDateTime: DateTime(2025, 4, 17, 09, 03), // Apr 17, 2025 at 9:03 AM
              ),

              const SizedBox(height: 20),

              const Text(
                'wfm%a,a ui 17 jk n%yiam;skaod mQ¾jNd. 09\'03g rkajka  meye;s jia;%dNrKfhka ieriS lsß n;la yd t<lsß ñY% leú,s j¾.hla wkqNj lr W;=re ÈYdj n,d msg;aj hEu uekú\'',
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
                  'assets/images/nakath8.png',
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

              // White button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedWhiteButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Nakath7Screen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
