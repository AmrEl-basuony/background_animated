import 'package:flutter/material.dart';

extension OffsetMultiplication on Offset {
  Offset operator *(Offset other) {
    return Offset(dx * other.dx, dy * other.dy);
  }
}
