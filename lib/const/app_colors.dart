import 'package:flutter/material.dart';

class AppColors {
  static const bgColor = Color(0xffffffff);
  static const primary = Color(0xff111011);
  static const secondary = Color(0xff6fc7ff);
  static const black = Color.fromARGB(255, 17, 17, 17);
  static const white = Colors.white;
  static const whiteSplash = Colors.white12;
  static Color grey = const Color(0xff838990).withOpacity(0.7);
  static const lightGrey = Color.fromARGB(255, 242, 242, 242);

  static const MaterialColor primarySwatch = MaterialColor(
    0xff111011,
    {
      50: Color(0xff6e6b6e),
      100: Color(0xff545254),
      200: Color(0xff2b292b),
      300: Color(0xff1f1d1f),
      400: Color(0xff111011),
      500: Color(0xff141214),
      600: Color(0xff120f12),
      700: Color(0xff0d0a0d),
      800: Color(0xff0a070a),
      900: Color(0xff030103),
    },
  );
}
