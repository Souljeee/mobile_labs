import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(children: [
            StarrySky(),
            Positioned.fill(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/spaceship2.png',
                    ),
                    invertColors: true,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class StarrySky extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SkyPainter(),
      child: Container(),
    );
  }
}

class SkyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw black background
    final Paint backgroundPaint = Paint()..color = Colors.black;
    canvas.drawRect(
        Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height)),
        backgroundPaint);

    // Draw starry sky
    final Paint starPaint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round;

    final Random random = Random();
    for (int i = 0; i < 100; i++) {
      final double x = random.nextDouble() * size.width;
      final double y = random.nextDouble() * size.height;
      final double radius = random.nextDouble() * 1.5;
      canvas.drawCircle(Offset(x, y), radius, starPaint);
    }

    // Draw moon in the top right corner
    final Paint moonPaint = Paint()..strokeCap = StrokeCap.round;

    final double moonRadius = 30.0;
    final double moonX = size.width - moonRadius;
    final double moonY = 80.0;

    // Draw gray arc
    final Paint grayArcPaint = Paint()..color = Colors.grey[400]!;
    canvas.drawCircle(
      Offset(moonX - moonRadius / 2 - 15, moonY),
      moonRadius,
      grayArcPaint,
    );

    // Draw black circle
    final Paint blackCirclePaint = Paint()..color = Colors.black;
    canvas.drawCircle(
        Offset(moonX - moonRadius / 2, moonY), moonRadius, blackCirclePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
