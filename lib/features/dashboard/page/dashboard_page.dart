import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/features/daily/page/daily_page.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_event.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_state.dart';
import 'package:my_budget/features/dashboard/models/dashboard_item.dart';
import 'package:my_budget/features/dashboard/page/widgets/bottom_bar_widget.dart';
import 'package:my_budget/features/dashboard/page/widgets/app_bar_widget.dart';
import 'package:my_budget/features/report/page/report_page.dart';
import 'package:my_budget/features/setting/page/setting_page.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    var items = <DashboardItem>[
      DashboardItem("Daily", Colors.blue, Icons.calendar_month),
      DashboardItem("Report", Colors.green, Icons.list),
      DashboardItem("Setting", Colors.orangeAccent, Icons.settings),
    ];

    final bloc = context.read<DashboardBloc>();

    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      if (state is DashboardLoaded) {
        return Scaffold(
          appBar: AppBarWidget(
            state.screenIndex,
            items[state.screenIndex],
          ),
          backgroundColor: items[state.screenIndex].color,
          body: PageView(
            controller: pageController,
            onPageChanged: (index) => bloc.add(ChangeScreen(index)),
            children: [
              DailyPage(),
              ReportPage(),
              SettingPage(),
            ],
          ),
          bottomNavigationBar: BottomBarWidget(pageController, items),
          floatingActionButton: state.screenIndex == 0
              ? FloatingActionButton(
                  backgroundColor: items[state.screenIndex].color,
                  onPressed: () => (),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                )
              : null,
        );
      } else {
        return CircularProgressIndicator();
      }
    });
  }
}
