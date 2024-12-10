import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorSchemeSeed: Colors.blueAccent.shade100,
  brightness: Brightness.light,
  // TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: ZoomPageTransitionsBuilder(
        allowEnterRouteSnapshotting: false,
      ),
    },
  ),
  useMaterial3: true,
);
