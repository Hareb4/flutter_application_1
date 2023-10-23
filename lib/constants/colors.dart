import 'package:flutter/widgets.dart';

class AppColor {
  AppColor._();
  static const Color darkblue = Color(0xFF1d3557);
  static const Color sky = Color(0xFF457b9d);
  static const Color lightsky = Color(0xFFa8dadc);
  static const Color white = Color(0xFFf1faee);
  static const Color red = Color(0xFFE63946);
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      sky,
      darkblue,
    ],
  );
}
