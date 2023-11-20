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
              child: FlyingSpaceship(),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: AnalogClock(),
            ),
          ]),
        ),
      ),
    );
  }
}

class StarrySky extends StatefulWidget {
  @override
  State<StarrySky> createState() => _StarrySkyState();
}

class _StarrySkyState extends State<StarrySky> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _twinklingController;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    _twinklingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: SkyPainter(
            animationValue: _controller,
            twinklingController: _twinklingController,
          ),
          child: Container(),
        );
      },
    );
  }
}

class SkyPainter extends CustomPainter {
  final AnimationController animationValue;
  late AnimationController twinklingController;
  final Random random = Random();

  SkyPainter({
    required this.animationValue,
    required this.twinklingController,
  });

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

    for (int i = 0; i < 100; i++) {
      final double x = random.nextDouble() * size.width;
      final double y = random.nextDouble() * size.height;
      final double radius = random.nextDouble() * 1.5;

      double alpha = Tween(begin: 0.2, end: 1.0)
          .chain(CurveTween(curve: Curves.easeInOut))
          .transform(twinklingController.value);

      starPaint.color = Colors.white.withOpacity(alpha);

      canvas.drawCircle(Offset(x, y), radius, starPaint);
    }

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

    double blackShift = Tween(begin: 0.0, end: 100.0)
        .chain(CurveTween(curve: Curves.easeInOut))
        .transform(animationValue.value);

    final moonx = moonX - moonRadius / 2 + blackShift;

    canvas.drawCircle(Offset(moonx, moonY), moonRadius, blackCirclePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class FlyingSpaceship extends StatefulWidget {
  @override
  _FlyingSpaceshipState createState() => _FlyingSpaceshipState();
}

class _FlyingSpaceshipState extends State<FlyingSpaceship>
    with SingleTickerProviderStateMixin {
  late AnimationController _flightController;
  late Animation<Offset> _flightAnimation;

  @override
  void initState() {
    super.initState();

    _flightController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _flightAnimation = Tween<Offset>(
      begin: Offset(-1, 0), // Изменено начальное положение корабля
      end: Offset(1, 0),
    ).animate(_flightController);
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _flightAnimation,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/spaceship2.png'),
            invertColors: true,
          ),
        ),
      ),
    );
  }
}


class AnalogClock extends StatefulWidget {
  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // Update the clock every second
    _currentTime = DateTime.now();
    _controller.addListener(() {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: CustomPaint(
        painter: ClockPainter(
          currentTime: _currentTime,
          animationValue: _controller.value,
        ),
        child: Container(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ClockPainter extends CustomPainter {
  final DateTime currentTime;
  final double animationValue;

  ClockPainter({required this.currentTime, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    final double radius = min(centerX, centerY);

    // Draw clock face
    final Paint clockFacePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX, centerY), radius, clockFacePaint);

    // Draw clock border
    final Paint borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;
    canvas.drawCircle(Offset(centerX, centerY), radius, borderPaint);

    // Draw clock markings
    for (int i = 1; i <= 12; i++) {
      final double angle = (i - 3) * 30 * (pi / 180);
      final double markerX = centerX + cos(angle) * radius * 0.8;
      final double markerY = centerY + sin(angle) * radius * 0.8;

      final Paint markerPaint = Paint()
        ..color = Colors.black
        ..strokeWidth = 2.0;

      canvas.drawCircle(Offset(markerX, markerY), 8.0, markerPaint);
    }

    // Draw clock hands
    final double seconds = currentTime.second.toDouble();
    final double minutes = currentTime.minute.toDouble();
    final double hours = (currentTime.hour % 12 + minutes / 60).toDouble();

    drawHand(canvas, centerX, centerY, radius * 0.6, hours * 30 + minutes * 0.5);
    drawHand(canvas, centerX, centerY, radius * 0.8, minutes * 6);
    drawHand(canvas, centerX, centerY, radius * 0.9, seconds * 6 * animationValue);
  }

  void drawHand(Canvas canvas, double centerX, double centerY, double length, double angle) {
    final Paint handPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    final double handX = centerX + cos(angle * (pi / 180)) * length;
    final double handY = centerY + sin(angle * (pi / 180)) * length;

    canvas.drawLine(Offset(centerX, centerY), Offset(handX, handY), handPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
