import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:my_budget/features/dashboard/page/dashboard_page.dart';
import 'package:my_budget/features/transaction/bloc/transaction_bloc.dart';
import 'package:my_budget/features/transaction/bloc/transaction_event.dart';
import 'package:my_budget/features/transaction/page/transaction_add_page.dart';
import 'package:my_budget/routes/paths.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final appRoutes = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: Paths.DASHBOARD,
  routes: [
    GoRoute(
      path: Paths.DASHBOARD,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => DashboardBloc(),
          child: DashboardPage(),
        );
      },
    ),
    GoRoute(
      path: Paths.TRANSACTION_ADD,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => TransactionBloc()..add(LoadTypes()),
          child: TransactionAddPage(),
        );
      },
    ),
  ],
);
