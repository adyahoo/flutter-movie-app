import 'dart:ui';

import 'package:flutter/material.dart';

extension RGBA on Color {
  static Color rgba(int r, int g, int b, double opacity) {
    return Color.fromRGBO(r, g, b, opacity);
  }
}

abstract class PrimaryColor {
  static final main = RGBA.rgba(0, 38, 63, 1);
  static final light = RGBA.rgba(217, 244, 252, 1);
}

abstract class SecondaryColor {
  static final main = RGBA.rgba(1, 180, 228, 1);
  static final pressed = RGBA.rgba(14, 165, 206, 1);
}

abstract class TextColor {
  static final primary = RGBA.rgba(0, 0, 0, 0.8);
  static final secondary = RGBA.rgba(0, 0, 0, 0.6);
  static final placeholder = RGBA.rgba(207, 207, 207, 1);
  static final label = RGBA.rgba(136, 136, 136, 1);
}

abstract class NeutralColor {
  static final neutral70 = RGBA.rgba(117, 117, 117, 1);
  static final neutral50 = RGBA.rgba(194, 194, 194, 1);
  static final neutral40 = RGBA.rgba(224, 224, 224, 1);
  static final neutral10 = RGBA.rgba(255, 255, 255, 1);
}

abstract class OtherColor {
  static final lineDivider = RGBA.rgba(244, 244, 244, 1);
  static final dot = RGBA.rgba(196, 196, 196, 1);
}

const shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);
