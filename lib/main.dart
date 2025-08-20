import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_budget/data/drift/app_database.dart';
import 'package:my_budget/data/drift/daos/category_dao.dart';
import 'package:my_budget/data/drift/daos/type_dao.dart';
import 'package:my_budget/features/report/bloc/report_bloc.dart';
import 'package:my_budget/features/setting/bloc/setting_bloc.dart';
import 'package:my_budget/features/setting/bloc/setting_state.dart';
import 'package:my_budget/features/setting/models/setting.dart';
import 'package:my_budget/features/transaction/list/bloc/transaction_list_bloc.dart';
import 'package:my_budget/routes/routes.dart';
import 'package:my_budget/theme/app_theme.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final db = AppDatabase();
  getIt.registerSingleton<AppDatabase>(db);
  getIt.registerSingleton<TypeDao>(TypeDao(db));
  getIt.registerSingleton<CategoryDao>(CategoryDao(db));

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SettingBloc()),
        BlocProvider(create: (_) => TransactionListBloc()),
        BlocProvider(create: (_) => ReportBloc()),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('id')],
        path: 'lib/assets/translations',
        fallbackLocale: const Locale('en'),
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(builder: (context, state) {
      if (state.hasBeenInitialed == null) {
        return MaterialApp(
          home: Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        );
      } else {
        if (context.locale.countryCode == null) {
          context.setLocale(Locale(state.appLanguage!));
        }
        return MaterialApp.router(
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: state.appTheme == APP_THEME.LIGHT
              ? ThemeMode.light
              : ThemeMode.dark,
          routerConfig: appRoutes,
        );
      }
    });
  }
}
