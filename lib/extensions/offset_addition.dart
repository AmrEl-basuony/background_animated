import 'package:flutter/material.dart';

extension OffsetAddition on Offset {
  Offset operator +(Offset other) {
    return Offset(dx + other.dx, dy + other.dy);
  }
}
