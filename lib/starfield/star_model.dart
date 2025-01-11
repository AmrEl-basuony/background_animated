import 'dart:math';

import 'package:flutter/material.dart';

class StarModel {
  double x, y, z, pz;
  final double width, height;
  final Random random;
  final Color color;
  final OutlinedBorder shape;
  final bool fillShape;

  StarModel({
    required this.fillShape,
    required this.x,
    required this.y,
    required this.z,
    required this.pz,
    required this.random,
    required this.width,
    required this.height,
    required this.color,
    required this.shape,
  });

  factory StarModel.create(double width, double height, Random random,
      Color color, OutlinedBorder shape, bool fillShape) {
    return StarModel(
      fillShape: fillShape,
      x: random.nextDouble() * width * 2 - width,
      y: random.nextDouble() * height * 2 - height,
      z: random.nextDouble() * width,
      pz: random.nextDouble() * width,
      color: color,
      width: width,
      random: random,
      height: height,
      shape: shape,
    );
  }

  void update(double speed) {
    z -= speed;
    if (z < 1) {
      z = width;
      x = random.nextDouble() * width * 2 - width;
      y = random.nextDouble() * height * 2 - height;
      pz = z;
    }
  }

  void show(
      Canvas canvas, double width, double height, Paint paint, bool trail) {
    if (z <= 0) return;
    paint.color = color;

    double sx = (x / z) * width / 2 + width / 2;
    double sy = (y / z) * height / 2 + height / 2;

    double r = (1 - z / width) * 16;
    if (r < 0) r = 0;

    fillShape
        ? canvas.drawPath(
            shape.getOuterPath(
              Rect.fromCircle(
                center: Offset(sx, sy),
                radius: r,
              ),
            ),
            paint)
        : shape
            .copyWith(
              side: shape.side.copyWith(
                color: color,
              ),
            )
            .paint(
                canvas,
                Rect.fromCircle(
                  center: Offset(sx, sy),
                  radius: r,
                ));

    double px = (x / pz) * width / 2 + width / 2;
    double py = (y / pz) * height / 2 + height / 2;

    pz = z;

    if (trail) canvas.drawLine(Offset(px, py), Offset(sx, sy), paint);
  }
}
