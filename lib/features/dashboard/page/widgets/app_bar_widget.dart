import 'package:flutter/material.dart';
import 'package:my_budget/features/daily/functions/daily_app_bar_actions.dart';
import 'package:my_budget/features/dashboard/models/dashboard_page_setting.dart';
import 'package:my_budget/features/report/functions/report_app_bar_actions.dart';
import 'package:my_budget/features/setting/functions/setting_app_bar_actions.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final int screenIndex;
  final DashboardPageSetting pageSetting;

  const AppBarWidget({
    required this.screenIndex,
    required this.pageSetting,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: pageSetting.color,
      leading: Icon(pageSetting.icon),
      title: Text(pageSetting.title),
      titleSpacing: 0,
      actions: switch (screenIndex) {
        0 => dailyAppBarActions(context),
        1 => reportAppBarActions(context),
        2 => settingAppBarActions(),
        _ => []
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
