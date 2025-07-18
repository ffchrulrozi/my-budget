import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_state.dart';
import 'package:my_budget/features/dashboard/models/dashboard_item.dart';
import 'package:my_budget/features/dashboard/page/widgets/body_widget.dart';
import 'package:my_budget/features/dashboard/page/widgets/bottom_bar_widget.dart';
import 'package:my_budget/features/dashboard/page/widgets/top_widget.dart';
import 'package:my_budget/features/dashboard/page/widgets/app_bar_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    var items = <DashboardItem>[
      DashboardItem("Today", Colors.blue, Icons.check),
      DashboardItem("Report", Colors.green, Icons.list),
      DashboardItem("Calendar", Colors.orangeAccent, Icons.calendar_month),
      DashboardItem("Setting", Colors.pinkAccent, Icons.settings),
    ];

    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      if (state is DashboardLoaded) {
        return Scaffold(
          appBar: AppBarWidget(items[state.screenIndex]),
          backgroundColor: items[state.screenIndex].color,
          body: Column(
            children: [
              TopWidget(
                screenIndex: state.screenIndex,
              ),
              Expanded(
                child: BodyWidget(
                  screenIndex: state.screenIndex,
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomBarWidget(items),
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
