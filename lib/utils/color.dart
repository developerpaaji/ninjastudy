import 'dart:math';

import 'package:flutter/material.dart';

Color getBlackOrWhite(Color color) {
  var r = color.red; // hexToR
  var g = color.green; // hexToG
  var b = color.blue; // hexToB
  var uicolors = [r / 255, g / 255, b / 255];
  var c = uicolors.map((col) {
    if (col <= 0.03928) {
      return col / 12.92;
    }
    return pow((col + 0.055) / 1.055, 2.4);
  }).toList();
  var L = (0.2126 * c[0]) + (0.7152 * c[1]) + (0.0722 * c[2]);
  return (L > 0.179) ? Colors.black : Colors.white;
}

Color generateRandomColor(String text) {
  int hash = 0;
  for (var i = 0; i < text.length; i++) {
    hash = text.codeUnitAt(i) + ((hash << 5) - hash);
  }
  String color = "0xff";
  for (var i = 0; i < 3; i++) {
    int value = (hash >> (i * 8)) & 0xff;
    String partHexS = "00" + value.toRadixString(16);
    color += partHexS.substring(partHexS.length - 2);
  }

  return Color(int.parse(color));
}

LinearGradient generateRandomGradient(String text) {
  Color color1 = generateRandomColor(text);
  return LinearGradient(colors: [color1, color1.withOpacity(0.8)]);
}
