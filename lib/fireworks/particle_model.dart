import 'package:flutter/material.dart';

class ParticleModel {
  final double particleWidth, particleHeight;
  final Color particleColor;
  final OutlinedBorder particleShape;
  final bool fillParticleShape;
  int lifeTime;
  Offset pos;
  Offset velocity;
  Offset acceleration;

  ParticleModel({
    this.pos = Offset.zero,
    required this.velocity,
    this.acceleration = Offset.zero,
    required this.particleWidth,
    required this.particleHeight,
    required this.particleColor,
    required this.particleShape,
    required this.fillParticleShape,
    this.lifeTime = 255,
  });

  void draw(Canvas canvas, Size size, Paint paint) {
    final Rect rect = Rect.fromCenter(
        center: pos, width: particleWidth, height: particleHeight);
    paint.color = particleColor.withAlpha(lifeTime);

    fillParticleShape
        ? canvas.drawPath(
            particleShape.getOuterPath(
              rect,
            ),
            paint,
          )
        : particleShape
            .copyWith(
              side: particleShape.side.copyWith(
                color: paint.color,
              ),
            )
            .paint(
              canvas,
              rect,
            );

    velocity *= 0.9;
    lifeTime -= 4;
    velocity += acceleration;
    pos += velocity;
    acceleration *= 0;
  }
}
