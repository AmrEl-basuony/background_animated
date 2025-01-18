import 'dart:math';

import 'package:background_animated/fireworks/particle_model.dart';
import 'package:flutter/material.dart';

class FireworkModel {
  final double width, height;
  final Random random;
  final Color color;
  final OutlinedBorder shape;
  final bool fillShape;
  Offset pos;
  Offset velocity;
  Offset acceleration;
  List<ParticleModel> particles;
  bool exploded = false;

  FireworkModel({
    required this.fillShape,
    this.pos = Offset.zero,
    required this.velocity,
    this.acceleration = Offset.zero,
    required this.random,
    required this.width,
    required this.height,
    required this.color,
    required this.shape,
    this.particles = const [],
  });

  factory FireworkModel.create(
    double width,
    double height,
    Random random,
    Color color,
    OutlinedBorder shape,
    bool fillShape,
    Offset pos,
    Offset velocity,
    Offset acceleration,
  ) {
    return FireworkModel(
      fillShape: fillShape,
      color: color,
      width: width,
      random: random,
      height: height,
      shape: shape,
      pos: pos,
      velocity: velocity,
      acceleration: acceleration,
    );
  }

  void draw(Canvas canvas, Size size, Paint paint) {
    final Rect rect =
        Rect.fromCenter(center: pos, width: width, height: height);

    fillShape
        ? canvas.drawPath(
            shape.getOuterPath(
              rect,
            ),
            paint,
          )
        : shape
            .copyWith(
              side: shape.side.copyWith(
                color: color,
              ),
            )
            .paint(
              canvas,
              rect,
            );
            
    velocity += acceleration;
    velocity.dy < 0 ? pos += velocity : exploded = true;
  }
}
