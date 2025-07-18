import 'package:flutter/material.dart';
import 'package:my_budget/features/calendar/screens/calendar_top_screen.dart';
import 'package:my_budget/features/report/screens/report_top_screen.dart';
import 'package:my_budget/features/setting/screens/setting_top_screen.dart';
import 'package:my_budget/features/today/screens/today_top_screen.dart';

class TopWidget extends StatelessWidget {
  final int screenIndex;
  const TopWidget({required this.screenIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: 100,
      child: IndexedStack(
        index: screenIndex,
        children: [
          TodayTopScreen(),
          ReportTopScreen(),
          CalendarTopScreen(),
          SettingTopScreen(),
        ],
      ),
    );
  }
}

class TabItem {
  final String label;
  final IconData icon;

  TabItem(this.label, this.icon);
}
