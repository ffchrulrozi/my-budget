import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  useMaterial3: true,
  
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    foregroundColor: Colors.white,
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme:
      ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
  useMaterial3: true,

  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    foregroundColor: Colors.white,
  ),
);
