import 'package:flutter/material.dart';
import 'package:my_budget/routes/routes.dart';
import 'package:my_budget/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: appTheme,
      routerConfig: appRoutes,
    );
  }
}
