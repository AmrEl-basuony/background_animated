import 'dart:math';

import 'package:flutter/material.dart';

import 'drop_model.dart';

class ParallaxRainPainter extends CustomPainter {
  final int numberOfDrops;
  List<DropModel> dropList = <DropModel>[];
  late Paint paintObject;
  late Size dropSize;
  final double dropFallSpeed;
  final double dropHeight;
  final double dropWidth;
  final int numberOfLayers;
  final bool trail;
  final List<Color> dropColors;
  final double trailStartFraction;
  final double distanceBetweenLayers;
  final double degrees;
  late final ValueNotifier notifier;
  final OutlinedBorder shape;
  final bool fillShape;
  Random random = Random();

  ParallaxRainPainter({
    required this.shape,
    required this.fillShape,
    required this.numberOfDrops,
    required this.degrees,
    required this.dropFallSpeed,
    required this.numberOfLayers,
    required this.trail,
    required this.dropHeight,
    required this.dropWidth,
    required this.dropColors,
    required this.trailStartFraction,
    required this.distanceBetweenLayers,
    required this.notifier,
  }) : super(repaint: notifier);

  void initialize(Canvas canvas, Size size) {
    paintObject = Paint()
      ..color = dropColors[0]
      ..style = PaintingStyle.fill;
    double effectiveLayer;
    for (int i = 0; i < numberOfDrops; i++) {
      double x = random.nextDouble() * size.width;
      double y = random.nextDouble() * size.height;
      int layerNumber = random.nextInt(numberOfLayers);
      effectiveLayer = layerNumber * distanceBetweenLayers;
      dropSize = Size(dropWidth, dropHeight);
      dropList.add(
        DropModel(
          drop: Offset(x, y) &
              Size(
                dropSize.width + (dropSize.width * effectiveLayer),
                dropSize.height + (dropSize.height * effectiveLayer),
              ),
          dropSpeed: dropFallSpeed + (dropFallSpeed * effectiveLayer),
          dropLayer: layerNumber,
          dropColor: dropColors[random.nextInt(dropColors.length)],
        ),
      );
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(degrees * (pi / 180));
    size = Size(
        size.width * cos(degrees * (pi / 180)) +
            size.height * sin(degrees * (pi / 180)),
        size.width * sin(degrees * (pi / 180)) +
            size.height * cos(degrees * (pi / 180)));
    canvas.translate(-size.width / 2, -size.height / 2);

    if (dropList.isEmpty) {
      initialize(canvas, size);
    }
    double effectiveLayer;
    for (int i = 0; i < numberOfDrops; i++) {
      if (dropList[i].drop.top + dropList[i].dropSpeed < size.height) {
        dropList[i].drop = Offset(dropList[i].drop.left,
                dropList[i].drop.top + dropList[i].dropSpeed) &
            dropList[i].drop.size;
      } else {
        int layer = random.nextInt(numberOfLayers);
        effectiveLayer = layer * distanceBetweenLayers;
        dropList[i].drop = Offset(random.nextDouble() * size.width,
                -(dropSize.height + (dropSize.height * effectiveLayer))) &
            Size(dropSize.width + (dropSize.width * effectiveLayer),
                dropSize.height + (dropSize.height * effectiveLayer));
        dropList[i].dropSpeed =
            dropFallSpeed + (dropFallSpeed * effectiveLayer);
        dropList[i].dropLayer = layer;
        dropList[i].dropColor = dropColors[random.nextInt(dropColors.length)];
      }

      paintObject.color = dropList[i]
          .dropColor
          .withValues(alpha: ((dropList[i].dropLayer + 1) / numberOfLayers));

      fillShape
          ? canvas.drawPath(
              shape.getOuterPath(
                dropList[i].drop,
              ),
              (trail)
                  ? (Paint()
                    ..shader = LinearGradient(
                      stops: [trailStartFraction, 1.0],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [paintObject.color, Colors.transparent],
                    ).createShader(
                      dropList[i].drop,
                    ))
                  : paintObject,
            )
          : shape
              .copyWith(
                side: shape.side.copyWith(
                  color: paintObject.color,
                ),
              )
              .paint(
                canvas,
                dropList[i].drop,
              );
    }
  }

  @override
  bool shouldRepaint(ParallaxRainPainter oldDelegate) => true;
}
