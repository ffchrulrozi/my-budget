import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_state.dart';
import 'package:my_budget/features/dashboard/models/dashboard_page_setting.dart';

class BottomBarWidget extends StatelessWidget {
  final PageController pageController;
  final List<DashboardPageSetting> pageSettings;

  const BottomBarWidget({
    required this.pageController,
    required this.pageSettings,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 15,
      left: 0,
      right: 0,
      child: Center(
        child:  Container(
          height: 50,
          decoration: BoxDecoration(
            color: Color.fromRGBO(225, 225, 225, 1),
            borderRadius: BorderRadius.circular(25),
          ),
          child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state is DashboardLoaded) {
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: pageSettings.length,
                  itemBuilder: (context, index) => BottomBarMenu(
                    pageController: pageController,
                    index: index,
                    screenIndex: state.screenIndex,
                    pageSettings: pageSettings,
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      )
    );
  }
}

class BottomBarMenu extends StatelessWidget {
  final PageController pageController;
  final int index;
  final int screenIndex;
  final List<DashboardPageSetting> pageSettings;

  const BottomBarMenu({
    required this.pageController,
    required this.index,
    required this.screenIndex,
    required this.pageSettings,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final bloc = context.read<DashboardBloc>();

    return InkWell(
      onTap: () {
        pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
        // bloc.add(ChangeScreen(index));
      },
      child: Container(
        height: 50,
        width: 75,
        decoration: BoxDecoration(
          color: index == screenIndex ? pageSettings[screenIndex].color : null,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Icon(
          pageSettings[index].icon,
          color: index == screenIndex ? Colors.white : null,
        ),
      ),
    );
  }
}
