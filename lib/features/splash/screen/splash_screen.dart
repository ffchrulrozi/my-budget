import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_budget/routes/paths.dart';
import 'package:my_budget/utils/helper/divider_helper.dart';
import 'package:my_budget/utils/helper/style_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) context.go(Paths.DASHBOARD);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "lib/assets/img/splash.gif",
              width: 150,
              height: 150,
            ),
            v(5),
            Text(
              "Money Come, Money Go",
              style: text(context).titleLarge,
            )
          ],
        ),
      ),
    );
  }
}
