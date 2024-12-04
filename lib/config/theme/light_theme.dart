import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorSchemeSeed: Colors.blueAccent.shade100,
  brightness: Brightness.light,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      // Use PredictiveBackPageTransitionsBuilder to get the predictive back route transition!
      TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
    },
  ),
  useMaterial3: true,
);
