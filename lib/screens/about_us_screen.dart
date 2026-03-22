import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/custom_app_bar.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  Future<void> _launchFeedbackForm() async {
    final url = Uri.parse('https://forms.gle/DraJwqRsNGp6v2Lw8'); // 🔁 Replace with your real form
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Could not launch the link: $e');
      // Optionally show a SnackBar
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'woyia yd fhdackd'),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Tfí woyia yd fhdackd wmfj;a fhduq lrkak\'',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'TharuDigitalNikini',
                color: Color(0xFFD4AF37),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'මෙම නැකැත් සීට්ටුව - 2025 Mobile එක Android දුරකතනයන් සඳහා develop කර ඇති අතර ඉදිරි වසර යන්හිදී Apple IOS සඳහාද නිකුත් කිරීමට බලා පොරොත්තු වෙමු. දැනට මෙය Google Play Store වෙතද නිකුත් කර නොමැත. (ඉදිරියේදී Play Store හරහා Download කරගැනීමට හැකිවනු ඇත.) දැනට Experiment අවධියේ ඇති App එකක් බැවින් ඔබේ වටිනා අදහස්, යෝජනා සහ චෝදනා පහත Button එක Click කිරීමෙන් ලබාදෙන ලෙස ඉල්ලා සිටිමු. ඔබ සැමට ස්තූතිය !',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _launchFeedbackForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5C0000),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'woyia yd fhdackd',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'TharuDigitalNikini',
                    color: Color(0xFFD4AF37),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Column(
              children: [
                Image.asset('assets/images/nd_logo.png', height: 50),
                const SizedBox(height: 8),
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
          ],
        ),
      ),
    );
  }
}
