import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final appRoutes = GoRouter(
  navigatorKey: navigatorKey,
  routes: [],
);
