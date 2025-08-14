import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_budget/data/drift/app_database.dart';
import 'package:my_budget/data/drift/daos/category_dao.dart';
import 'package:my_budget/data/drift/daos/type_dao.dart';
import 'package:my_budget/features/report/bloc/report_bloc.dart';
import 'package:my_budget/features/transaction/list/bloc/transaction_list_bloc.dart';
import 'package:my_budget/routes/routes.dart';
import 'package:my_budget/theme/app_theme.dart';

final getIt = GetIt.instance;

void main() {
  final db = AppDatabase();
  getIt.registerSingleton<AppDatabase>(db);
  getIt.registerSingleton<TypeDao>(TypeDao(db));
  getIt.registerSingleton<CategoryDao>(CategoryDao(db));

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TransactionListBloc()),
        BlocProvider(create: (_) => ReportBloc()),
      ],
      child: MaterialApp.router(
        theme: appTheme,
        routerConfig: appRoutes,
      ),
    );
  }
}
