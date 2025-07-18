import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_state.dart';
import 'package:my_budget/features/dashboard/page/widgets/body_widget.dart';
import 'package:my_budget/features/dashboard/page/widgets/bottom_bar_widget.dart';
import 'package:my_budget/features/dashboard/page/widgets/top_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    const backgroundColors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.pink,
    ];

    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      if (state is DashboardLoaded) {
        return Scaffold(
          backgroundColor: backgroundColors[state.screenIndex],
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
          bottomNavigationBar:
              BottomBarWidget(backgroundColors: backgroundColors),
        );
      } else {
        return CircularProgressIndicator();
      }
    });
  }
}
