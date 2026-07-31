import 'package:flutter/material.dart';

String colorToHex(Color color) {
  return color.toARGB32().toRadixString(16).substring(2).toUpperCase();
}

Color hexToColor(String hex) {
  return Color(int.parse('FF$hex', radix: 16));
}