import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_event.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_state.dart';
import 'package:my_budget/features/dashboard/models/dashboard_page_setting.dart';
import 'package:my_budget/features/dashboard/page/widgets/bottom_bar_widget.dart';
import 'package:my_budget/features/report/page/report_page.dart';
import 'package:my_budget/features/setting/bloc/setting_bloc.dart';
import 'package:my_budget/features/setting/models/setting.dart';
import 'package:my_budget/features/setting/page/setting_page.dart';
import 'package:my_budget/features/transaction/list/page/transaction_list_page.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final isThemeLight =
        context.watch<SettingBloc>().state.appTheme == APP_THEME.LIGHT;
    final bloc = context.read<DashboardBloc>();

    var pageSettings = <DashboardPageSetting>[
      DashboardPageSetting(
          "dailyTitle".tr(), isThemeLight ? Colors.blue : Colors.black, Icons.calendar_month, isThemeLight),
      DashboardPageSetting(
          "reportTitle".tr(), isThemeLight ? Colors.green : Colors.black, Icons.list, isThemeLight),
      DashboardPageSetting("settingTitle".tr(), isThemeLight ? Colors.orangeAccent : Colors.black,
          Icons.settings, isThemeLight),
    ];

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
                    TransactionListPage(pageSetting: pageSettings[0]),
                    ReportPage(pageSetting: pageSettings[1]),
                    SettingPage(pageSetting: pageSettings[2]),
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
