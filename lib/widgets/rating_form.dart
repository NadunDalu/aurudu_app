import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../app_theme.dart';
import '../utils/network_utils.dart';

class RatingForm extends StatefulWidget {
  const RatingForm({super.key});

  @override
  State<RatingForm> createState() => _RatingFormState();
}

class _RatingFormState extends State<RatingForm> {
  double _rating = 0;
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isSubmitting = false;
  bool _hasSubmitted = false;

  @override
  void dispose() {
    _commentController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submitFeedback() async {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a star rating.')),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final bool hasInternet = await InternetConnection().hasInternetAccess;
    if (!hasInternet) {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
      });
      NetworkUtils.showNetworkErrorDialog(context);
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('reviews').add({
        'name': _nameController.text.trim(),
        'rating': _rating,
        'comment': _commentController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      
      setState(() {
        _hasSubmitted = true;
      });

      // Show follow-up message based on rating
      if (_rating >= 4) {
        _showMessageDialog(
          'Thank You!',
          'We truly appreciate your positive rating! It means a lot to us.',
          Icons.favorite,
          Colors.redAccent,
        );
      } else {
        _showMessageDialog(
          'Thank You for your feedback',
          'We will carefully review your feedback to improve your future experience.',
          Icons.feedback,
          Colors.orangeAccent,
        );
      }
    } catch (e) {
      if (!mounted) return;
      NetworkUtils.showNetworkErrorDialog(context);
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _showMessageDialog(String title, String message, IconData icon, Color iconColor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AuruduTheme.darkBg,
        title: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: AuruduTheme.gold, fontSize: 20),
              ),
            ),
          ],
        ),
        content: Text(
          message,
          style: const TextStyle(color: AuruduTheme.warmWhite, fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close', style: TextStyle(color: AuruduTheme.gold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_hasSubmitted) {
      return AuruduTheme.glassContainer(
        opacity: 0.15,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Column(
            children: [
              Icon(
                _rating >= 4 ? Icons.favorite : Icons.check_circle,
                color: _rating >= 4 ? Colors.redAccent : Colors.greenAccent,
                size: 50,
              ),
              const SizedBox(height: 16),
              const Text(
                'Feedback Submitted Successfully!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AuruduTheme.gold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Thank you for helping us improve.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AuruduTheme.warmWhite),
              ),
            ],
          ),
        ),
      );
    }

    return AuruduTheme.glassContainer(
      opacity: 0.15,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Rate Your Experience',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AuruduTheme.gold,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemSize: 36,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: AuruduTheme.gold,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(20),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AuruduTheme.gold.withAlpha(50)),
              ),
              child: TextField(
                controller: _nameController,
                style: const TextStyle(color: AuruduTheme.warmWhite),
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  hintText: 'Your Name (Optional)',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(20),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AuruduTheme.gold.withAlpha(50)),
              ),
              child: TextField(
                controller: _commentController,
                maxLines: 4,
                style: const TextStyle(color: AuruduTheme.warmWhite),
                decoration: const InputDecoration(
                  hintText: 'Tell us how we can improve... (Optional)',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitFeedback,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AuruduTheme.festiveRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  disabledBackgroundColor: Colors.grey[800],
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: AuruduTheme.gold,
                        ),
                      )
                    : const Text(
                        'Submit Feedback',
                        style: TextStyle(
                          fontSize: 18,
                          color: AuruduTheme.gold,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
