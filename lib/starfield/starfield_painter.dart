import 'dart:math';

import 'package:flutter/material.dart';

import 'star_model.dart';

class StarfieldPainter extends CustomPainter {
  List<StarModel> stars = [];
  final double speed;
  final int numberOfStars;
  late Paint paintObject;
  final bool trail;
  final List<Color> starColors;
  final ValueNotifier notifier;
  final OutlinedBorder shape;
  Random random = Random();

  StarfieldPainter({
    required this.numberOfStars,
    required this.speed,
    required this.trail,
    required this.starColors,
    required this.notifier,
    required this.shape,
  }) : super(repaint: notifier);

  void initialize(Canvas canvas, Size size) {
    paintObject = Paint()
      ..color = starColors[0]
      ..style = PaintingStyle.fill;

    for (int i = 0; i < numberOfStars; i++) {
      stars.add(StarModel.create(
        size.width,
        size.height,
        random,
        starColors[random.nextInt(starColors.length)],
        shape,
      ));
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (stars.isEmpty) {
      initialize(canvas, size);
    }

    for (int i = 0; i < numberOfStars; i++) {
      stars[i].update(speed);
      stars[i].show(canvas, size.width, size.height, paintObject, trail);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
