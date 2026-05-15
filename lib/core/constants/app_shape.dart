import 'package:flutter/material.dart';

abstract class AppShape {
  static const double radiusS = 12;
  static const double radiusM = 18;
  static const double radiusL = 24;
  static const double radiusXL = 32;
}

abstract class AppElevation {
  static const List<BoxShadow> cardSoft = [
    BoxShadow(color: Color(0x0F1F1108), blurRadius: 16, offset: Offset(0, 4)),
  ];
  static const List<BoxShadow> cardStrong = [
    BoxShadow(color: Color(0x1A1F1108), blurRadius: 24, offset: Offset(0, 8)),
  ];
  static const List<BoxShadow> orange = [
    BoxShadow(color: Color(0x55FF6B1A), blurRadius: 24, offset: Offset(0, 8)),
  ];
}
