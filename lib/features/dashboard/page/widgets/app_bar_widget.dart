import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_budget/features/dashboard/models/dashboard_item.dart';
import 'package:my_budget/utils/helper/divider_helper.dart';
import 'package:my_budget/utils/helper/style_helper.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final int screenIndex;
  final DashboardItem item;

  const AppBarWidget(
    this.screenIndex,
    this.item, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void showDateFilter() {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: SizedBox(
              height: 400,
              child: SfDateRangePicker(
                navigationDirection:
                    DateRangePickerNavigationDirection.vertical,
                showNavigationArrow: true,
                enablePastDates: true,
                backgroundColor: Colors.white,
                todayHighlightColor: Colors.teal,
                onCancel: () => context.pop(),
                onSubmit: (val) => context.pop(),
                cellBuilder: (context, details) {
                  return Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          details.date.day.toString(),
                          style: text(context).bodyLarge,
                        ),
                        Text(
                          "2.6jt",
                          style: text(context).labelSmall,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      );
    }

    List<Widget> buildActions() {
      switch (screenIndex) {
        case 0:
          return [
            InkWell(
              onTap: () => showDateFilter(),
              child: Row(
                children: [
                  Text("19 Jun 2025"),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
            h(2),
            DropdownButton<String>(
              alignment: Alignment.centerRight,
              value: 'Income',
              style: TextStyle(textBaseline: TextBaseline.alphabetic),
              iconEnabledColor: Colors.white,
              underline: Container(),
              items: ['All', 'Income', 'Outcome']
                  .map(
                    (option) => DropdownMenuItem(
                      value: option,
                      child: Text(
                        option,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (val) => (),
              selectedItemBuilder: (context) => ['All', 'Income', 'Outcome']
                  .map(
                    (option) => DropdownMenuItem(
                      value: option,
                      child: Text(
                        option,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                  .toList(),
            ),
            h(1),
          ];
        case 1:
          return [
            InkWell(
              onTap: () => showDateFilter(),
              child: Row(
                children: [
                  Text("This Week"),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
            h(2),
            DropdownButton<String>(
              alignment: Alignment.centerRight,
              value: 'Income',
              style: TextStyle(textBaseline: TextBaseline.alphabetic),
              iconEnabledColor: Colors.white,
              underline: Container(),
              items: ['Income', 'Outcome']
                  .map(
                    (option) => DropdownMenuItem(
                      value: option,
                      child: Text(
                        option,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (val) => (),
              selectedItemBuilder: (context) => ['Income', 'Outcome']
                  .map(
                    (option) => DropdownMenuItem(
                      value: option,
                      child: Text(
                        option,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                  .toList(),
            ),
            h(1),
          ];
        case 2:
          return [];
        default:
          return [];
      }
    }

    return AppBar(
      backgroundColor: item.color,
      leading: Icon(item.icon),
      title: Text(item.title),
      titleSpacing: 0,
      actions: buildActions(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
