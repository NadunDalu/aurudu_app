import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../app_theme.dart';
import '../widgets/rating_form.dart';
import '../widgets/feedback_carousel.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuruduTheme.darkBg,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: 'woyia yd fhdackd'),
      body: AuruduTheme.backgroundStack(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AuruduTheme.goldShimmer.createShader(bounds),
                  child: const Text(
                    'Tfí woyia yd fhdackd wmfj;a fhduq lrkak\'',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'TharuDigitalNikini',
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                AuruduTheme.glassContainer(
                  opacity: 0.15,
                  child: const Text(
                    'මෙම නැකැත් සීට්ටුව - 2026 Mobile App එක Android දුරකතනයන් සඳහා develop කර ඇති අතර ඉදිරි වසර යන්හිදී Apple IOS සඳහාද නිකුත් කිරීමට බලා පොරොත්තු වෙමු. දැනට මෙය Google Play Store වෙතද නිකුත් කර නොමැත. දැනට Experiment අවධියේ ඇති App එකක් බැවින් ඔබේ වටිනා අදහස්, යෝජනා සහ චෝදනා පහත Form එක මගින් ලබාදෙන ලෙස ඉල්ලා සිටිමු. ඔබ සැමට ස්තූතියී !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: AuruduTheme.warmWhite,
                      height: 1.6,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const RatingForm(),
                const SizedBox(height: 30),
                const FeedbackCarousel(),
                const SizedBox(height: 40),
                Column(
                  children: [
                    Image.asset('assets/images/nd_logo.png', height: 50),
                    const SizedBox(height: 8),
                    const Text(
                      'Developed by: Nadun Daluwatta',
                      textAlign: TextAlign.center,
                      style: AuruduTheme.footerText,
                    ),
                    const Text(
                      'nsdaluwatta@gmail.com',
                      style: AuruduTheme.footerText,
                    ),
                    const Text(
                      'www.nadun.live',
                      style: AuruduTheme.footerText,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
