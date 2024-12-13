import 'dart:math';

import 'package:flutter/material.dart';

class MeteorDemo extends StatelessWidget {
  const MeteorDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        MeteorShower(
          numberOfMeteors: 10,
          duration: const Duration(seconds: 5),
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 96, 96, 96),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Meteor shower',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: [Colors.white, Colors.white.withOpacity(0.2)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MeteorShower extends StatefulWidget {
  final Widget child;
  final int numberOfMeteors;
  final Duration duration;

  const MeteorShower({
    super.key,
    required this.child,
    this.numberOfMeteors = 10,
    this.duration = const Duration(seconds: 10),
  });

  @override
  _MeteorShowerState createState() => _MeteorShowerState();
}

class _MeteorShowerState extends State<MeteorShower>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Meteor> _meteors = [];
  final double meteorAngle = pi / 4;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initializeMeteors(Size size) {
    if (_meteors.isEmpty) {
      _meteors = List.generate(
          widget.numberOfMeteors, (_) => Meteor(meteorAngle, size));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        _initializeMeteors(size);

        return Stack(
          children: [
            widget.child,
            ...List.generate(widget.numberOfMeteors, (index) {
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final meteor = _meteors[index];
                  final progress = ((_controller.value - meteor.delay) % 1.0) /
                      meteor.duration;
                  if (progress < 0 || progress > 1) {
                    return const SizedBox.shrink();
                  }

                  return Positioned(
                    left: meteor.startX +
                        (meteor.endX - meteor.startX) * progress,
                    top: meteor.startY +
                        (meteor.endY - meteor.startY) * progress,
                    child: Opacity(
                      opacity: (1 - progress) * 0.8,
                      child: Transform.rotate(
                        angle: 315 * (pi / 180),
                        child: CustomPaint(
                          size: const Size(2, 20),
                          painter: MeteorPainter(),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        );
      },
    );
  }
}

class MeteorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint trailPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.white, Colors.white.withOpacity(0)],
        end: Alignment.topCenter,
        begin: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), trailPaint);

    final Paint circlePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width / 2, size.height), 2, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Meteor {
  final double startX;
  final double startY;
  late double endX;
  late double endY;
  final double delay;
  final double duration;

  Meteor(double angle, Size size)
      : startX = Random().nextDouble() * size.width / 2,
        startY = Random().nextDouble() * size.height / 4 - size.height / 4,
        delay = Random().nextDouble(),
        duration = 0.3 + Random().nextDouble() * 0.7 {
    var distance = size.height / 3;
    endX = startX + cos(angle) * distance;
    endY = startY + sin(angle) * distance;
  }
}
