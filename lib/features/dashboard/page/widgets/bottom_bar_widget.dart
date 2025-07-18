import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_event.dart';
import 'package:my_budget/features/dashboard/bloc/dashboard_state.dart';
import 'package:my_budget/features/dashboard/models/dashboard_item.dart';

class BottomBarWidget extends StatelessWidget {
  final List<DashboardItem> items;

  const BottomBarWidget(
    this.items, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DashboardBloc>();

    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 0.1),
          borderRadius: BorderRadius.circular(25),
        ),
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoaded) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => bloc.add(ChangeScreen(index)),
                    child: Container(
                      height: 50,
                      width: 75,
                      decoration: BoxDecoration(
                        color: index == state.screenIndex
                            ? items[state.screenIndex].color
                            : null,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Icon(
                        items[index].icon,
                        color: index == state.screenIndex ? Colors.white : null,
                      ),
                    ),
                  );
                },
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
