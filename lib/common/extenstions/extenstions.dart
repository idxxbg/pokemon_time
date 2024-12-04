import 'package:flutter/material.dart';

extension Capitalize on String {
  String capitalize() {
    String firstCharacter = characters.first.toUpperCase();
    String remaining = substring(1);

    return firstCharacter + remaining;
  }
}
