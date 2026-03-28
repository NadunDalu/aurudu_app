import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/custom_app_bar.dart';
import '../app_theme.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  Future<void> _launchFeedbackForm() async {
    final url = Uri.parse('https://forms.gle/DraJwqRsNGp6v2Lw8');
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Could not launch the link: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'මෙම නැකැත් සීට්ටුව - 2025 Mobile එක Android දුරකතනයන් සඳහා develop කර ඇති අතර ඉදිරි වසර යන්හිදී Apple IOS සඳහාද නිකුත් කිරීමට බලා පොරොත්තු වෙමු. දැනට මෙය Google Play Store වෙතද නිකුත් කර නොමැත. (ඉදිරියේදී Play Store හරහා Download කරගැනීමට හැකිවනු ඇත.) දැනට Experiment අවධියේ ඇති App එකක් බැවින් ඔබේ වටිනා අදහස්, යෝජනා සහ චෝදනා පහත Button එක Click කිරීමෙන් ලබාදෙන ලෙස ඉල්ලා සිටිමු. ඔබ සැමට ස්තූතිය !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: AuruduTheme.warmWhite,
                      height: 1.6,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: AuruduTheme.buttonGradient,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: AuruduTheme.festiveRed.withAlpha((0.4 * 255).toInt()),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _launchFeedbackForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'woyia yd fhdackd',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'TharuDigitalNikini',
                          color: AuruduTheme.gold,
                        ),
                      ),
                    ),
                  ),
                ),
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
                      'nadundaluwatta26@gmail.com',
                      style: AuruduTheme.footerText,
                    ),
                    const Text(
                      'www.nadundaluwatta.me',
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
