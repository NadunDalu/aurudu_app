import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math' as math;
import '../widgets/custom_app_bar.dart';

class CompassDetailsScreen extends StatefulWidget {
  const CompassDetailsScreen({super.key});

  @override
  State<CompassDetailsScreen> createState() => _CompassDetailsScreenState();
}

class _CompassDetailsScreenState extends State<CompassDetailsScreen> {
  double? _direction;

  @override
  void initState() {
    super.initState();
    _startCompass();
  }

  void _startCompass() {
    FlutterCompass.events?.listen((CompassEvent event) {
      setState(() {
        _direction = event.heading;
      });
    });
  }

  String _getDirectionLabel(double? direction) {
    if (direction == null) return 'Loading...';
    final degrees = (direction + 360) % 360; // Normalize to 0-360
    if (degrees >= 337.5 || degrees < 22.5) return 'N';
    if (degrees >= 22.5 && degrees < 67.5) return 'NE';
    if (degrees >= 67.5 && degrees < 112.5) return 'E';
    if (degrees >= 112.5 && degrees < 157.5) return 'SE';
    if (degrees >= 157.5 && degrees < 202.5) return 'S';
    if (degrees >= 202.5 && degrees < 247.5) return 'SW';
    if (degrees >= 247.5 && degrees < 292.5) return 'W';
    if (degrees >= 292.5 && degrees < 337.5) return 'NW';
    return 'N'; // Default
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'ÈYdj n,d.kak',
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content with Compass and Bottom Info
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Centered Compass
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      const SizedBox(height: 20),
                      // Compass Widget
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Ancient Compass Background
                            Container(
                              width: 300,
                              height: 300,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const RadialGradient(
                                  colors: [
                                    Color(0xFFD4AF37), // Goldish tone for ancient look
                                    Color(0xFF8B4513), // Brownish edge
                                  ],
                                  stops: [0.7, 1.0],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha((0.5 * 255).toInt()),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                            // Inner Parchment-like Circle
                            Container(
                              width: 260,
                              height: 260,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFF5E6CC), // Parchment color
                                border: Border.all(
                                  color: const Color(0xFF8B4513),
                                  width: 3,
                                ),
                              ),
                            ),
                            // Compass direction labels with red arrowheads for main directions
                            SizedBox(
                              width: 260,
                              height: 260,
                              child: Stack(
                                children: [
                                  // North with Red Arrowhead
                                  Positioned(
                                    top: 0,
                                    left: 125,
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.arrow_drop_up,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                        const SizedBox(height: 5),
                                        const Text('N',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Times New Roman')),
                                      ],
                                    ),
                                  ),
                                  // North-East
                                  Positioned(
                                    top: 40,
                                    right: 40,
                                    child: Transform.rotate(
                                      angle: -math.pi / 4,
                                      child: const Text('NE',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontFamily: 'Times New Roman')),
                                    ),
                                  ),
                                  // East with Red Arrowhead
                                  Positioned(
                                    right: 0,
                                    top: 125,
                                    child: Row(
                                      children: [
                                        const Text('E',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 24,
                                                fontFamily: 'Times New Roman')),
                                        const SizedBox(width: 5),
                                        const Icon(
                                          Icons.arrow_right,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // South-East
                                  Positioned(
                                    bottom: 40,
                                    right: 40,
                                    child: Transform.rotate(
                                      angle: math.pi / 4,
                                      child: const Text('SE',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontFamily: 'Times New Roman')),
                                    ),
                                  ),
                                  // South with Red Arrowhead
                                  Positioned(
                                    bottom: 0,
                                    left: 125,
                                    child: Column(
                                      children: [
                                        const Text('S',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 24,
                                                fontFamily: 'Times New Roman')),
                                        const SizedBox(height: 5),
                                        const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // South-West
                                  Positioned(
                                    bottom: 40,
                                    left: 40,
                                    child: Transform.rotate(
                                      angle: -math.pi / 4,
                                      child: const Text('SW',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontFamily: 'Times New Roman')),
                                    ),
                                  ),
                                  // West with Red Arrowhead
                                  Positioned(
                                    left: 0,
                                    top: 125,
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.arrow_left,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                        const SizedBox(width: 5),
                                        const Text('W',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 24,
                                                fontFamily: 'Times New Roman')),
                                      ],
                                    ),
                                  ),
                                  // North-West
                                  Positioned(
                                    top: 40,
                                    left: 40,
                                    child: Transform.rotate(
                                      angle: math.pi / 4,
                                      child: const Text('NW',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontFamily: 'Times New Roman')),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Rotating compass needle (single arrow for North)
                            if (_direction != null)
                              Transform.rotate(
                                angle: ((_direction ?? 0) * (math.pi / 180) * -1),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // North Arrow
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 8,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        ),
                                        Transform.translate(
                                          offset: const Offset(0, -100),
                                          child: const Icon(
                                            Icons.arrow_drop_up,
                                            color: Colors.red,
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // South Arm (without arrow)
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 8,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Center Circle
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFD4AF37), // Gold center
                                        border: Border(
                                          top: BorderSide(
                                              color: Color(0xFF8B4513), width: 2),
                                          bottom: BorderSide(
                                              color: Color(0xFF8B4513), width: 2),
                                          left: BorderSide(
                                              color: Color(0xFF8B4513), width: 2),
                                          right: BorderSide(
                                              color: Color(0xFF8B4513), width: 2),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            // Direction text
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _direction != null
                                      ? '${_direction!.toStringAsFixed(0)}°'
                                      : 'Loading...',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontFamily: 'Times New Roman',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  _direction != null
                                      ? _getDirectionLabel(_direction)
                                      : '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'Times New Roman',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        ';sria ;,hl ÿrl;kh ;nd ÈYdj n,kak\'lerflk oKafâ r;a meye B ;, ysi W;=re ÈYdjg yrjd ÈYdjka n,d.kak\'\n^fuh ish¨ ÿrl;k i|yd l%shd fkdlrk nj i,lkak\'&',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'TharuDigitalNikini',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom Section with New Content
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        'iqn w¨;a wjqreoaola fõjd æ',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFFD4AF37),
                          fontFamily: 'TharuDigitalNikini',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Centered Developer Info
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/nd_logo.png',
                            height: 60,
                          ),
                          const SizedBox(height: 10),
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}