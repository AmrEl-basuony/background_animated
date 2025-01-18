import 'dart:math';

import 'package:flutter/material.dart';

import 'firework_model.dart';
import 'particle_model.dart';

class FireworksPainter extends CustomPainter {
  late Paint paintObject;
  final double width;
  final double height;
  final List<Color> colors;
  final ValueNotifier notifier;
  final OutlinedBorder shape;
  final bool fillShape;
  final int numberOfFireworks;
  final OutlinedBorder particleShape;
  final bool fillParticleShape;
  final double particleWidth;
  final double particleHeight;
  final int numberOfParticles;
  final List<Color> particleColors;
  Random random = Random();
  List<FireworkModel> fireworks = [];

  FireworksPainter({
    required this.particleShape,
    required this.fillParticleShape,
    required this.particleWidth,
    required this.particleHeight,
    required this.numberOfParticles,
    required this.particleColors,
    required this.fillShape,
    required this.numberOfFireworks,
    required this.height,
    required this.width,
    required this.colors,
    required this.notifier,
    required this.shape,
  }) : super(repaint: notifier);

  void initialize(Canvas canvas, Size size) {
    paintObject = Paint()
      ..color = colors[0]
      ..style = PaintingStyle.fill;

    for (int i = 0; i < numberOfFireworks; i++) {
      fireworks.add(
        FireworkModel.create(
          width,
          height,
          random,
          colors[random.nextInt(colors.length)],
          shape,
          fillShape,
          Offset(
            random.nextDouble() * size.width,
            size.height,
          ),
          Offset(0, (-random.nextInt(8) - 12) * size.height / 1000),
          Offset(0, gravity),
        ),
      );
    }
  }

  double gravity = 0.2;

  @override
  void paint(Canvas canvas, Size size) {
    if (fireworks.isEmpty) {
      initialize(canvas, size);
    }

    gravity = 0.2 * size.height / 1000;

    for (int i = 0; i < numberOfFireworks; i++) {
      if (!fireworks[i].exploded) {
        fireworks[i].draw(canvas, size, paintObject);
      } else if (fireworks[i].particles.isEmpty && fireworks[i].exploded) {
        final Color color =
            particleColors[random.nextInt(particleColors.length)];

        fireworks[i].particles = List.generate(
          numberOfParticles,
          (ind) => ParticleModel(
            pos: fireworks[i].pos,
            acceleration: Offset(0, gravity),
            velocity: random2D() * (random.nextInt(10) + 2.0),
            particleWidth: particleWidth,
            particleHeight: particleHeight,
            particleColor: color,
            particleShape: particleShape,
            fillParticleShape: fillParticleShape,
          ),
        );
      } else if (fireworks[i].exploded &&
          fireworks[i].particles.first.lifeTime > 0) {
        for (int ind = 0; ind < fireworks[i].particles.length; ind++) {
          fireworks[i].particles[ind].draw(canvas, size, paintObject);
        }
      } else if (random.nextDouble() > 0.98) {
        fireworks[i] = FireworkModel.create(
          width,
          height,
          random,
          colors[random.nextInt(colors.length)],
          shape,
          fillShape,
          Offset(
            random.nextDouble() * size.width,
            size.height,
          ),
          Offset(0, (-random.nextInt(8) - 12) * size.height / 1000),
          Offset(0, gravity),
        );
      }
    }
  }

  Offset random2D() {
    final double angle = random.nextDouble() * 2 * pi;
    return Offset(cos(angle), sin(angle));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
