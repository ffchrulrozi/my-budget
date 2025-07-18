import 'package:flutter/material.dart';
import 'package:my_budget/features/calendar/screens/calendar_body_screen.dart';
import 'package:my_budget/features/report/screens/report_body_screen.dart';
import 'package:my_budget/features/setting/screens/setting_body_screen.dart';
import 'package:my_budget/features/today/screens/today_body_screen.dart';

class BodyWidget extends StatelessWidget {
  final int screenIndex;
  const BodyWidget({required this.screenIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: IndexedStack(
        index: screenIndex,
        children: [
          TodayBodyScreen(),
          ReportBodyScreen(),
          CalendarBodyScreen(),
          SettingBodyScreen(),
        ],
      ),
    );
  }
}
