import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../app_theme.dart';

class FeedbackCarousel extends StatefulWidget {
  const FeedbackCarousel({super.key});

  @override
  State<FeedbackCarousel> createState() => _FeedbackCarouselState();
}

class _FeedbackCarouselState extends State<FeedbackCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  Timer? _timer;
  int _itemCount = 0;

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide(int itemCount) {
    _itemCount = itemCount;
    _timer?.cancel(); // Cancel any existing timer safely
    
    // Only slide if we have more than 1 item
    if (_itemCount <= 1) return;

    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        int nextPage = _pageController.page!.round() + 1;
        if (nextPage >= _itemCount) {
          nextPage = 0;
          _pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn,
          );
        } else {
          _pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  Widget _buildConnectionLost() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Recent Feedback',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AuruduTheme.gold,
              ),
            ),
          ),
          AuruduTheme.glassContainer(
            opacity: 0.15,
            child: const Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_off, color: AuruduTheme.festiveRed, size: 40),
                  SizedBox(height: 16),
                  Text(
                    'Connection Lost',
                    style: TextStyle(
                      color: AuruduTheme.gold,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Please connect to the internet to view recent feedback.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AuruduTheme.warmWhite,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: InternetConnection().hasInternetAccess,
      builder: (context, netSnapshot) {
        if (netSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(color: AuruduTheme.gold),
            ),
          );
        }

        final bool hasInternet = netSnapshot.data ?? false;
        if (!hasInternet) {
          return _buildConnectionLost();
        }

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('reviews')
              .orderBy('timestamp', descending: true)
              .limit(10)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return _buildConnectionLost();
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(color: AuruduTheme.gold),
                ),
              );
            }

            final docs = snapshot.data?.docs ?? [];
            if (docs.isEmpty) {
              _timer?.cancel();
              return const SizedBox.shrink();
            }

            // Begin auto-slide once we know how many items there are
            if (_itemCount != docs.length) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) _startAutoSlide(docs.length);
              });
            }

            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Recent Feedback',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AuruduTheme.gold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 180,
                  child: PageView.builder(
                    itemCount: docs.length,
                    controller: _pageController,
                    // If the user manually interacts, pause the timer briefly
                    onPageChanged: (index) {
                      _startAutoSlide(docs.length);
                    },
                    itemBuilder: (context, index) {
                      final data = docs[index].data() as Map<String, dynamic>;
                      final double rating = (data['rating'] as num?)?.toDouble() ?? 5.0;
                      final String comment = data['comment']?.toString() ?? '';
                      final String name = data['name']?.toString() ?? '';
                      final String displayName = name.isNotEmpty ? name : 'Anonymous';

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: AuruduTheme.glassContainer(
                          opacity: 0.15,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RatingBarIndicator(
                                  rating: rating,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: AuruduTheme.gold,
                                  ),
                                  itemCount: 5,
                                  itemSize: 20.0,
                                  direction: Axis.horizontal,
                                ),
                                const SizedBox(height: 12),
                                if (comment.isNotEmpty) ...[
                                  Expanded(
                                    child: Text(
                                      '"$comment"',
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: AuruduTheme.warmWhite,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                                Text(
                                  '- $displayName -',
                                  style: const TextStyle(
                                    color: AuruduTheme.gold,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
