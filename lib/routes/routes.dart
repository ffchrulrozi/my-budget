import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:my_budget/features/dashboard/page/dashboard_page.dart';
import 'package:my_budget/routes/paths.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final appRoutes = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: Paths.DASHBOARD.path,
  routes: [
    GoRoute(
      path: Paths.DASHBOARD.path,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => DashboardBloc(),
          child: DashboardPage(),
        );
      },
    ),
  ],
);
