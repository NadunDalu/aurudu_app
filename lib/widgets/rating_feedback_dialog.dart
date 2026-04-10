import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../app_theme.dart';

/// A modern, Play Store-style in-app rating and feedback dialog.
///
/// Captures a 1–5 star rating and an optional comment,
/// stores them in the Firestore "reviews" collection,
/// and shows contextual follow-up messages.
class RatingFeedbackDialog extends StatefulWidget {
  const RatingFeedbackDialog({super.key});

  /// Convenience method to show the dialog from anywhere.
  static Future<void> show(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Rating Dialog',
      barrierColor: Colors.black.withAlpha((0.6 * 255).toInt()),
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (_, __, ___) => const Center(
        child: RatingFeedbackDialog(),
      ),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );
        return ScaleTransition(
          scale: curved,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  @override
  State<RatingFeedbackDialog> createState() => _RatingFeedbackDialogState();
}

class _RatingFeedbackDialogState extends State<RatingFeedbackDialog>
    with SingleTickerProviderStateMixin {
  double _rating = 0;
  final _commentController = TextEditingController();
  bool _isSubmitting = false;
  bool _submitted = false;
  String? _errorMessage;

  // Prevent multiple submissions within a short time
  DateTime? _lastSubmissionTime;
  static const _submissionCooldown = Duration(seconds: 30);

  late AnimationController _starAnimController;
  late Animation<double> _starAnimation;

  @override
  void initState() {
    super.initState();
    _starAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _starAnimation = CurvedAnimation(
      parent: _starAnimController,
      curve: Curves.elasticOut,
    );
    // Animate stars in after a short delay
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _starAnimController.forward();
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    _starAnimController.dispose();
    super.dispose();
  }

  bool get _canSubmit {
    if (_lastSubmissionTime == null) return true;
    return DateTime.now().difference(_lastSubmissionTime!) >= _submissionCooldown;
  }

  Future<void> _submitRating() async {
    // Validate rating
    if (_rating == 0) {
      setState(() => _errorMessage = 'Please select a star rating');
      return;
    }

    // Check cooldown
    if (!_canSubmit) {
      final remaining = _submissionCooldown -
          DateTime.now().difference(_lastSubmissionTime!);
      setState(() {
        _errorMessage =
            'Please wait ${remaining.inSeconds}s before submitting again';
      });
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      await FirebaseFirestore.instance.collection('reviews').add({
        'rating': _rating.toInt(),
        'comment': _commentController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      _lastSubmissionTime = DateTime.now();

      if (mounted) {
        setState(() {
          _isSubmitting = false;
          _submitted = true;
        });

        // Auto-close after showing thank-you/feedback message
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
          _errorMessage = 'Failed to submit. Please check your connection.';
        });
        debugPrint('Firebase submission error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.88,
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2A0505),
              Color(0xFF1A0000),
              Color(0xFF2A0505),
            ],
          ),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: AuruduTheme.gold.withAlpha((0.4 * 255).toInt()),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AuruduTheme.gold.withAlpha((0.15 * 255).toInt()),
              blurRadius: 30,
              spreadRadius: 2,
            ),
            BoxShadow(
              color: Colors.black.withAlpha((0.5 * 255).toInt()),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: _submitted ? _buildThankYouView() : _buildRatingView(),
      ),
    );
  }

  Widget _buildRatingView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AuruduTheme.gold.withAlpha((0.3 * 255).toInt()),
                  AuruduTheme.festiveRed.withAlpha((0.3 * 255).toInt()),
                ],
              ),
              border: Border.all(
                color: AuruduTheme.gold.withAlpha((0.5 * 255).toInt()),
              ),
            ),
            child: const Icon(
              Icons.rate_review_rounded,
              color: AuruduTheme.gold,
              size: 30,
            ),
          ),
          const SizedBox(height: 16),

          // Title
          ShaderMask(
            shaderCallback: (bounds) =>
                AuruduTheme.goldShimmer.createShader(bounds),
            child: const Text(
              'Rate This App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Your feedback helps us improve!',
            style: TextStyle(
              fontSize: 13,
              color: AuruduTheme.warmWhite.withAlpha((0.7 * 255).toInt()),
            ),
          ),
          const SizedBox(height: 24),

          // Star rating
          ScaleTransition(
            scale: _starAnimation,
            child: RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemSize: 42,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              unratedColor:
                  AuruduTheme.gold.withAlpha((0.2 * 255).toInt()),
              glowColor:
                  AuruduTheme.gold.withAlpha((0.4 * 255).toInt()),
              itemBuilder: (context, index) => const Icon(
                Icons.star_rounded,
                color: AuruduTheme.gold,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                  _errorMessage = null;
                });
              },
            ),
          ),
          const SizedBox(height: 8),

          // Rating label
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Text(
              _ratingLabel,
              key: ValueKey(_rating),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: _rating >= 4
                    ? AuruduTheme.lightGold
                    : AuruduTheme.warmWhite
                        .withAlpha((0.8 * 255).toInt()),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Comment field — always shown but with dynamic hint
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withAlpha((0.07 * 255).toInt()),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AuruduTheme.gold.withAlpha((0.2 * 255).toInt()),
              ),
            ),
            child: TextField(
              controller: _commentController,
              maxLines: 3,
              maxLength: 500,
              style: const TextStyle(
                color: AuruduTheme.warmWhite,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: _rating > 0 && _rating <= 3
                    ? 'What can we improve? (optional)'
                    : 'Share your thoughts... (optional)',
                hintStyle: TextStyle(
                  color:
                      AuruduTheme.warmWhite.withAlpha((0.4 * 255).toInt()),
                  fontSize: 14,
                ),
                contentPadding: const EdgeInsets.all(16),
                border: InputBorder.none,
                counterStyle: TextStyle(
                  color:
                      AuruduTheme.warmWhite.withAlpha((0.3 * 255).toInt()),
                  fontSize: 11,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Error message
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    color: Colors.redAccent.shade100,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(
                        color: Colors.redAccent.shade100,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 4),

          // Submit button
          SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                gradient: _isSubmitting
                    ? null
                    : const LinearGradient(
                        colors: [
                          AuruduTheme.festiveRed,
                          AuruduTheme.deepMaroon,
                        ],
                      ),
                color: _isSubmitting
                    ? AuruduTheme.deepMaroon.withAlpha((0.5 * 255).toInt())
                    : null,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AuruduTheme.gold.withAlpha((0.3 * 255).toInt()),
                ),
                boxShadow: _isSubmitting
                    ? null
                    : [
                        BoxShadow(
                          color: AuruduTheme.festiveRed
                              .withAlpha((0.3 * 255).toInt()),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitRating,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  disabledBackgroundColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: AuruduTheme.gold,
                          strokeWidth: 2.5,
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.send_rounded,
                              color: AuruduTheme.gold, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'Submit Review',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AuruduTheme.gold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Cancel link
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Maybe later',
              style: TextStyle(
                color: AuruduTheme.warmWhite.withAlpha((0.5 * 255).toInt()),
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThankYouView() {
    final isPositive = _rating >= 4;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Animated icon
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 500),
            curve: Curves.elasticOut,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: child,
              );
            },
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: isPositive
                      ? [
                          AuruduTheme.gold.withAlpha((0.3 * 255).toInt()),
                          AuruduTheme.lightGold
                              .withAlpha((0.2 * 255).toInt()),
                        ]
                      : [
                          AuruduTheme.festiveRed
                              .withAlpha((0.3 * 255).toInt()),
                          AuruduTheme.deepMaroon
                              .withAlpha((0.2 * 255).toInt()),
                        ],
                ),
                border: Border.all(
                  color: isPositive
                      ? AuruduTheme.gold.withAlpha((0.5 * 255).toInt())
                      : AuruduTheme.festiveRed
                          .withAlpha((0.5 * 255).toInt()),
                ),
              ),
              child: Icon(
                isPositive
                    ? Icons.favorite_rounded
                    : Icons.handshake_rounded,
                color:
                    isPositive ? AuruduTheme.gold : AuruduTheme.warmSaffron,
                size: 40,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Message
          ShaderMask(
            shaderCallback: (bounds) =>
                AuruduTheme.goldShimmer.createShader(bounds),
            child: Text(
              isPositive ? 'Thank You! 🎉' : 'We Appreciate It! 🙏',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            isPositive
                ? 'We\'re glad you enjoy the app!\nYour support means a lot to us.'
                : 'Your feedback is valuable!\nWe\'ll work hard to improve the experience.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AuruduTheme.warmWhite.withAlpha((0.8 * 255).toInt()),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  String get _ratingLabel {
    switch (_rating.toInt()) {
      case 1:
        return '😞 Poor';
      case 2:
        return '😕 Fair';
      case 3:
        return '🙂 Good';
      case 4:
        return '😊 Great';
      case 5:
        return '🤩 Excellent!';
      default:
        return 'Tap a star to rate';
    }
  }
}
