import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_event.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_state.dart';

class BottomBarWidget extends StatelessWidget {
  final List<Color> backgroundColors;
  const BottomBarWidget({required this.backgroundColors, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 0.1),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomBarItem(
                index: 0,
                icon: FontAwesomeIcons.check,
                backgroundColors: backgroundColors),
            BottomBarItem(
                index: 1, icon: Icons.list, backgroundColors: backgroundColors),
            BottomBarItem(
                index: 2,
                icon: Icons.calendar_month,
                backgroundColors: backgroundColors),
            BottomBarItem(
                index: 3,
                icon: Icons.settings,
                backgroundColors: backgroundColors)
          ],
        ),
      ),
    );
  }
}

class BottomBarItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final List<Color> backgroundColors;

  const BottomBarItem({
    required this.index,
    required this.icon,
    required this.backgroundColors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DashboardBloc>();

    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoaded) {
          return InkWell(
            onTap: () => bloc.add(ChangeScreen(index)),
            child: Container(
              height: 50,
              width: 75,
              decoration: BoxDecoration(
                color: index == state.screenIndex
                    ? backgroundColors[state.screenIndex]
                    : null,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                icon,
                color: index == state.screenIndex ? Colors.white : null,
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
