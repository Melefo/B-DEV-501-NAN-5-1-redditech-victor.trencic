import 'package:flutter/material.dart';

class RodditColors {
  static Map<int, Color> _pinkLuminance = {
    50: Color.fromRGBO(255, 103, 116, .1),
    100: Color.fromRGBO(255, 103, 116, .2),
    200: Color.fromRGBO(255, 103, 116, .3),
    300: Color.fromRGBO(255, 103, 116, .4),
    400: Color.fromRGBO(255, 103, 116, .5),
    500: Color.fromRGBO(255, 103, 116, .6),
    600: Color.fromRGBO(255, 103, 116, .7),
    700: Color.fromRGBO(255, 103, 116, .8),
    800: Color.fromRGBO(255, 103, 116, .9),
    900: Color.fromRGBO(255, 103, 116, 1),
  };

  static MaterialColor pink = MaterialColor(0xFFFF6774, _pinkLuminance);

  static Map<int, Color> _blueLuminance = {
    50: Color.fromRGBO(129, 138, 255, .1),
    100: Color.fromRGBO(129, 138, 255, .2),
    200: Color.fromRGBO(129, 138, 255, .3),
    300: Color.fromRGBO(129, 138, 255, .4),
    400: Color.fromRGBO(129, 138, 255, .5),
    500: Color.fromRGBO(129, 138, 255, .6),
    600: Color.fromRGBO(129, 138, 255, .7),
    700: Color.fromRGBO(129, 138, 255, .8),
    800: Color.fromRGBO(129, 138, 255, .9),
    900: Color.fromRGBO(129, 138, 255, 1),
  };

  static MaterialColor blue = MaterialColor(0xFF818AFF, _blueLuminance);
}

