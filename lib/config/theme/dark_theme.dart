import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorSchemeSeed: Colors.pinkAccent,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: ZoomPageTransitionsBuilder(
        allowEnterRouteSnapshotting: false,
        allowSnapshotting: false,
      ),
    },
  ),
  useMaterial3: true,
);
