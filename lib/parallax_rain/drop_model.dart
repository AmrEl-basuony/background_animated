import 'package:flutter/material.dart';

class DropModel {
  /// Represents a drop by a Rect object, i.e. a combination of Offset and Size
  Rect drop;

  /// The speed at which this drop is travelling
  double dropSpeed;

  /// The layer in which this drop is right now
  int dropLayer;

  /// The color that this drop has right now
  Color dropColor;

  DropModel({
    required this.drop,
    required this.dropSpeed,
    required this.dropLayer,
    required this.dropColor,
  });
}
