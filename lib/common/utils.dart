import 'dart:convert';

import 'package:flutter/material.dart';

Color getColorFromString(String input) {

  int hashCode = utf8.encode(input).fold(0, (int previousValue, int element) {
    return 31 * previousValue + element;
  });

  Color color = Color(hashCode & 0xFFFFFFFF).withOpacity(1.0);

  final hslColor = HSLColor.fromColor(color);
  final newHslColor = HSLColor.fromAHSL(
    color.alpha / 255.0,
    hslColor.hue,
    1,
    0.5,
  );

  return newHslColor.toColor();
}

String shortenNumber(int number) {
  if (number < 1000) {
    return number.toString();
  } else if (number < 10000) {
    final double thousands = number / 1000;
    return '${thousands.toStringAsFixed(1)}k';
  } else {
    final int thousands = (number / 1000).round();
    return '${thousands}k';
  }
}
