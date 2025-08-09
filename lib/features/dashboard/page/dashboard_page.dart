import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_event.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_state.dart';
import 'package:my_budget/features/dashboard/models/dashboard_page_setting.dart';
import 'package:my_budget/features/dashboard/page/widgets/bottom_bar_widget.dart';
import 'package:my_budget/features/report/page/report_page.dart';
import 'package:my_budget/features/setting/page/setting_page.dart';
import 'package:my_budget/features/transaction/bloc/transaction_bloc.dart';
import 'package:my_budget/features/transaction/bloc/transaction_event.dart';
import 'package:my_budget/features/transaction/page/transaction_page.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    var pageSettings = <DashboardPageSetting>[
      DashboardPageSetting("Daily", Colors.blue, Icons.calendar_month),
      DashboardPageSetting("Report", Colors.green, Icons.list),
      DashboardPageSetting("Setting", Colors.orangeAccent, Icons.settings),
    ];

    final bloc = context.read<DashboardBloc>();

    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      if (state is DashboardLoaded) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 75),
                child: PageView(
                  controller: pageController,
                  onPageChanged: (index) => bloc.add(ChangeScreen(index)),
                  children: [
                    BlocProvider(
                      create: (_) => TransactionBloc()..add(LoadTransactions()),
                      child: TransactionPage(pageSetting: pageSettings[0]),
                    ),
                    BlocProvider(
                      create: (_) => TransactionBloc()..add(LoadTransactions()),
                      child: ReportPage(pageSetting: pageSettings[1]),
                    ),
                    BlocProvider(
                      create: (_) => TransactionBloc()..add(LoadTransactions()),
                      child: SettingPage(pageSetting: pageSettings[2]),
                    ),
                  ],
                ),
              ),
              BottomBarWidget(
                pageController: pageController,
                pageSettings: pageSettings,
              ),
            ],
          ),
        );
      } else {
        return CircularProgressIndicator();
      }
    });
  }
}
