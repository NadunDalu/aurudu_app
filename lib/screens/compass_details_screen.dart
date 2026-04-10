import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math' as math;
import '../widgets/custom_app_bar.dart';
import '../app_theme.dart';

class CompassDetailsScreen extends StatefulWidget {
  const CompassDetailsScreen({super.key});

  @override
  State<CompassDetailsScreen> createState() => _CompassDetailsScreenState();
}

class _CompassDetailsScreenState extends State<CompassDetailsScreen> {
  double? _direction;
  double _smoothDirection = 0;

  @override
  void initState() {
    super.initState();
    _startCompass();
  }

  void _startCompass() {
    FlutterCompass.events?.listen((CompassEvent event) {
      if (mounted) {
        setState(() {
          _direction = event.heading;
          if (_direction != null) {
            // Smooth interpolation for fluid rotation
            double target = _direction!;
            double diff = target - _smoothDirection;
            // Handle wrap-around (e.g., 359 -> 1)
            if (diff > 180) diff -= 360;
            if (diff < -180) diff += 360;
            _smoothDirection += diff * 0.3;
            // Normalize
            _smoothDirection = (_smoothDirection + 360) % 360;
          }
        });
      }
    });
  }

  String _getDirectionLabel(double? direction) {
    if (direction == null) return 'Loading...';
    final degrees = (direction + 360) % 360;
    if (degrees >= 337.5 || degrees < 22.5) return 'N';
    if (degrees >= 22.5 && degrees < 67.5) return 'NE';
    if (degrees >= 67.5 && degrees < 112.5) return 'E';
    if (degrees >= 112.5 && degrees < 157.5) return 'SE';
    if (degrees >= 157.5 && degrees < 202.5) return 'S';
    if (degrees >= 202.5 && degrees < 247.5) return 'SW';
    if (degrees >= 247.5 && degrees < 292.5) return 'W';
    if (degrees >= 292.5 && degrees < 337.5) return 'NW';
    return 'N';
  }

  String _getSinhalaDirection(String dir) {
    switch (dir) {
      case 'N':
        return 'W;=r';
      case 'NE':
        return 'Bidk';
      case 'E':
        return 'kef.kysr';
      case 'SE':
        return '.sKsysr';
      case 'S':
        return 'ol=K';
      case 'SW':
        return 'ksß';
      case 'W':
        return 'niakdysr';
      case 'NW':
        return 'jhU';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final compassSize = MediaQuery.of(context).size.width * 0.82;
    final clampedSize = compassSize.clamp(280.0, 360.0);

    return Scaffold(
      backgroundColor: AuruduTheme.darkBg,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: 'ÈYdj n,d.kak'),
      body: AuruduTheme.backgroundStack(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 10),
                                // ═══════════════════════════════════════
                                // COMPASS WIDGET
                                // ═══════════════════════════════════════
                                SizedBox(
                                  width: clampedSize + 40,
                                  height: clampedSize + 40,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      // ── Outer Glow Ring ──
                                      Container(
                                        width: clampedSize + 20,
                                        height: clampedSize + 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.transparent,
                                          border: Border.all(
                                            color: AuruduTheme.gold.withAlpha(40),
                                            width: 2,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AuruduTheme.gold.withAlpha(25),
                                              blurRadius: 40,
                                              spreadRadius: 5,
                                            ),
                                          ],
                                        ),
                                      ),

                                      // ── Fixed North Indicator (triangle at top) ──
                                      Positioned(
                                        top: 0,
                                        child: CustomPaint(
                                          size: const Size(20, 16),
                                          painter: _NorthTrianglePainter(),
                                        ),
                                      ),

                                      // ═══════════════════════════════════
                                      // ROTATING DIAL PLATE
                                      // ═══════════════════════════════════
                                      Transform.rotate(
                                        angle: _direction != null
                                            ? (-_smoothDirection * math.pi / 180)
                                            : 0,
                                        child: SizedBox(
                                          width: clampedSize,
                                          height: clampedSize,
                                          child: CustomPaint(
                                            painter: _CompassDialPainter(
                                              compassSize: clampedSize,
                                            ),
                                          ),
                                        ),
                                      ),

                                      // ═══════════════════════════════════
                                      // FIXED NEEDLE (Always points up = North)
                                      // ═══════════════════════════════════
                                      SizedBox(
                                        width: clampedSize,
                                        height: clampedSize,
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            // Glow behind needle
                                            Container(
                                              width: 3,
                                              height: clampedSize * 0.65,
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: AuruduTheme.festiveRed
                                                        .withAlpha(100),
                                                    blurRadius: 16,
                                                    spreadRadius: 1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // North Pointer (Red/Gold) — top half
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ClipPath(
                                                  clipper: CompassNeedleClipper(
                                                      pointUp: true),
                                                  child: Container(
                                                    width: 28,
                                                    height: clampedSize * 0.32,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          AuruduTheme.festiveRed,
                                                          AuruduTheme.warmSaffron
                                                              .withAlpha(220),
                                                        ],
                                                        begin: Alignment.topCenter,
                                                        end: Alignment.bottomCenter,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: clampedSize * 0.32),
                                              ],
                                            ),
                                            // South Pointer (Silver/White) — bottom half
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                    height: clampedSize * 0.32),
                                                ClipPath(
                                                  clipper: CompassNeedleClipper(
                                                      pointUp: false),
                                                  child: Container(
                                                    width: 28,
                                                    height: clampedSize * 0.32,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Colors.white
                                                              .withAlpha(200),
                                                          Colors.grey
                                                              .withAlpha(120),
                                                        ],
                                                        begin: Alignment.topCenter,
                                                        end: Alignment.bottomCenter,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // Center Hub – outer ring
                                            Container(
                                              width: 34,
                                              height: 34,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AuruduTheme.darkBg,
                                                border: Border.all(
                                                  color: AuruduTheme.gold,
                                                  width: 2.5,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withAlpha(180),
                                                    blurRadius: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Center Hub – inner dot
                                            Container(
                                              width: 14,
                                              height: 14,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient: const RadialGradient(
                                                  colors: [
                                                    AuruduTheme.lightGold,
                                                    AuruduTheme.gold,
                                                  ],
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: AuruduTheme.gold
                                                        .withAlpha(100),
                                                    blurRadius: 8,
                                                    spreadRadius: 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // ═══════════════════════════════════
                                // DIGITAL READOUT
                                // ═══════════════════════════════════
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 36, vertical: 14),
                                  decoration:
                                      AuruduTheme.glassCard(opacity: 0.15, radius: 24),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Text(
                                            _direction != null
                                                ? '${((_direction! + 360) % 360).toStringAsFixed(1)}°'
                                                : '---°',
                                            style: const TextStyle(
                                              color: AuruduTheme.gold,
                                              fontSize: 40,
                                              fontFamily: 'Gafata-Regular',
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 2,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            _direction != null
                                                ? _getDirectionLabel(_direction)
                                                : '—',
                                            style: const TextStyle(
                                              color: AuruduTheme.warmWhite,
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 3,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (_direction != null) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          _getSinhalaDirection(
                                              _getDirectionLabel(_direction)),
                                          style: const TextStyle(
                                            color: AuruduTheme.warmSaffron,
                                            fontSize: 18,
                                            fontFamily: 'TharuDigitalNikini',
                                            letterSpacing: 2,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // Instruction Text
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 24),
                                  child: AuruduTheme.glassContainer(
                                    opacity: 0.12,
                                    child: const Text(
                                      ";sria ;,hl ÿrl;kh ;nd ÈYdj n,kak'r;= B;,h  wjYH ÈYdj iuÕ iumd; lr.kak' ÿrl;kfha by, me;a; fhduqù we;af; wod, ÈYdjg fõ'\n^fuh ish¨ ÿrl;k i|yd l%shd fkdlrk nj i,lkak'&",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AuruduTheme.warmWhite,
                                        fontFamily: 'TharuDigitalNikini',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Bottom Section
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) =>
                                    AuruduTheme.goldShimmer.createShader(bounds),
                                child: const Text(
                                  'iqn w¨;a wjqreoaola fõjd æ',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontFamily: 'TharuDigitalNikini',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Column(
                                children: [
                                  Image.asset('assets/images/nd_logo.png',
                                      height: 50),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Developed by: Nadun Daluwatta',
                                    textAlign: TextAlign.center,
                                    style: AuruduTheme.footerText,
                                  ),
                                  const Text('nsdaluwatta@gmail.com',
                                      style: AuruduTheme.footerText),
                                  const Text('www.nadun.live',
                                      style: AuruduTheme.footerText),
                                ],
                              ),
                            ],
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

// ═══════════════════════════════════════════════════════
// NORTH INDICATOR TRIANGLE (fixed at top of compass)
// ═══════════════════════════════════════════════════════
class _NorthTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [AuruduTheme.warmSaffron, AuruduTheme.festiveRed],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();

    // Glow
    canvas.drawPath(
      path,
      Paint()
        ..color = AuruduTheme.festiveRed.withAlpha(80)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ═══════════════════════════════════════════════════════
// ROTATING DIAL PAINTER (tick marks + direction labels)
// ═══════════════════════════════════════════════════════
class _CompassDialPainter extends CustomPainter {
  final double compassSize;

  _CompassDialPainter({required this.compassSize});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = compassSize / 2;

    // ── Background circle ──
    canvas.drawCircle(
      center,
      radius,
      Paint()..color = AuruduTheme.darkBg.withAlpha(180),
    );

    // ── Inner gradient circle ──
    canvas.drawCircle(
      center,
      radius - 8,
      Paint()
        ..shader = RadialGradient(
          colors: [
            AuruduTheme.gold.withAlpha(8),
            AuruduTheme.deepMaroon.withAlpha(60),
          ],
          stops: const [0.4, 1.0],
        ).createShader(Rect.fromCircle(center: center, radius: radius - 8)),
    );

    // ── Outer border ring ──
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = AuruduTheme.gold.withAlpha(50)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // ── Inner border ring ──
    canvas.drawCircle(
      center,
      radius - 8,
      Paint()
        ..color = AuruduTheme.gold.withAlpha(25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    // ── Tick marks ──
    for (int i = 0; i < 360; i += 5) {
      final angle = i * math.pi / 180 - math.pi / 2;
      final bool isMajor = i % 90 == 0;
      final bool isSecondary = i % 45 == 0 && !isMajor;
      final bool isMinor = i % 15 == 0 && !isMajor && !isSecondary;

      double tickLength;
      double tickWidth;
      int alpha;

      if (isMajor) {
        tickLength = 16;
        tickWidth = 3;
        alpha = 255;
      } else if (isSecondary) {
        tickLength = 12;
        tickWidth = 2;
        alpha = 200;
      } else if (isMinor) {
        tickLength = 8;
        tickWidth = 1.5;
        alpha = 120;
      } else {
        tickLength = 5;
        tickWidth = 1;
        alpha = 60;
      }

      final outerPoint = Offset(
        center.dx + (radius - 10) * math.cos(angle),
        center.dy + (radius - 10) * math.sin(angle),
      );
      final innerPoint = Offset(
        center.dx + (radius - 10 - tickLength) * math.cos(angle),
        center.dy + (radius - 10 - tickLength) * math.sin(angle),
      );

      canvas.drawLine(
        outerPoint,
        innerPoint,
        Paint()
          ..color = AuruduTheme.gold.withAlpha(alpha)
          ..strokeWidth = tickWidth
          ..strokeCap = StrokeCap.round,
      );

      // Degree numbers every 30°
      if (i % 30 == 0 && i % 90 != 0) {
        final textRadius = radius - 36;
        final textOffset = Offset(
          center.dx + textRadius * math.cos(angle),
          center.dy + textRadius * math.sin(angle),
        );

        final textPainter = TextPainter(
          text: TextSpan(
            text: '$i',
            style: TextStyle(
              color: AuruduTheme.gold.withAlpha(140),
              fontSize: 11,
              fontFamily: 'Gafata-Regular',
              fontWeight: FontWeight.w500,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();

        canvas.save();
        canvas.translate(textOffset.dx, textOffset.dy);
        canvas.rotate(angle + math.pi / 2);
        textPainter.paint(
          canvas,
          Offset(-textPainter.width / 2, -textPainter.height / 2),
        );
        canvas.restore();
      }
    }

    // ── Direction Labels ──
    final directions = [
      _DirectionInfo('N', 0, AuruduTheme.warmSaffron, 26, true),
      _DirectionInfo('NE', 45, AuruduTheme.gold, 16, false),
      _DirectionInfo('E', 90, AuruduTheme.gold, 22, true),
      _DirectionInfo('SE', 135, AuruduTheme.gold, 16, false),
      _DirectionInfo('S', 180, AuruduTheme.warmWhite, 22, true),
      _DirectionInfo('SW', 225, AuruduTheme.gold, 16, false),
      _DirectionInfo('W', 270, AuruduTheme.gold, 22, true),
      _DirectionInfo('NW', 315, AuruduTheme.gold, 16, false),
    ];

    for (final dir in directions) {
      final angle = dir.degrees * math.pi / 180 - math.pi / 2;
      final labelRadius = radius - (dir.isPrimary ? 55 : 48);
      final pos = Offset(
        center.dx + labelRadius * math.cos(angle),
        center.dy + labelRadius * math.sin(angle),
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: dir.label,
          style: TextStyle(
            color: dir.color,
            fontSize: dir.fontSize,
            fontWeight: dir.isPrimary ? FontWeight.bold : FontWeight.w500,
            fontFamily: 'Gafata-Regular',
            shadows: [
              Shadow(
                color: dir.color.withAlpha(100),
                blurRadius: 10,
              ),
            ],
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      canvas.save();
      canvas.translate(pos.dx, pos.dy);
      // Keep text upright relative to its position on the dial
      canvas.rotate(angle + math.pi / 2);
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DirectionInfo {
  final String label;
  final double degrees;
  final Color color;
  final double fontSize;
  final bool isPrimary;

  _DirectionInfo(
      this.label, this.degrees, this.color, this.fontSize, this.isPrimary);
}

// ═══════════════════════════════════════════════════════
// NEEDLE CLIPPER
// ═══════════════════════════════════════════════════════
class CompassNeedleClipper extends CustomClipper<Path> {
  final bool pointUp;
  CompassNeedleClipper({required this.pointUp});

  @override
  Path getClip(Size size) {
    final path = Path();
    if (pointUp) {
      path.moveTo(size.width / 2, 0); // Tip
      path.lineTo(size.width, size.height); // Bottom right
      path.lineTo(size.width / 2, size.height - 15); // Inner notch
      path.lineTo(0, size.height); // Bottom left
    } else {
      path.moveTo(0, 0); // Top left
      path.lineTo(size.width / 2, 15); // Inner notch
      path.lineTo(size.width, 0); // Top right
      path.lineTo(size.width / 2, size.height); // Tip
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
