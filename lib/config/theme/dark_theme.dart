import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorSchemeSeed: Colors.pinkAccent,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      // Use PredictiveBackPageTransitionsBuilder to get the predictive back route transition!
      TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
    },
  ),
  useMaterial3: true,
);
