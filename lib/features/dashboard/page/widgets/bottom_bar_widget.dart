import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_event.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_state.dart';
import 'package:my_budget/features/dashboard/models/dashboard_item.dart';

class BottomBarWidget extends StatelessWidget {
  final PageController pageController;
  final List<DashboardItem> items;

  const BottomBarWidget(
    this.pageController,
    this.items, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 90),
      color: Colors.white,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: Color.fromRGBO(225, 225, 225, 1),
          borderRadius: BorderRadius.circular(25),
        ),
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoaded) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) => BottomBarMenu(
                  pageController: pageController,
                  index: index,
                  screenIndex: state.screenIndex,
                  items: items,
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class BottomBarMenu extends StatelessWidget {
  final PageController pageController;
  final int index;
  final int screenIndex;
  final List<DashboardItem> items;

  const BottomBarMenu({
    required this.pageController,
    required this.index,
    required this.screenIndex,
    required this.items,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DashboardBloc>();

    return InkWell(
      onTap: () {
        bloc.add(ChangeScreen(index));

        pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      },
      child: Container(
        height: 50,
        width: 75,
        decoration: BoxDecoration(
          color: index == screenIndex ? items[screenIndex].color : null,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Icon(
          items[index].icon,
          color: index == screenIndex ? Colors.white : null,
        ),
      ),
    );
  }
}
