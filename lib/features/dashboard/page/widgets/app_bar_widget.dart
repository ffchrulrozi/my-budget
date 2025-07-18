import 'package:flutter/material.dart';
import 'package:my_budget/features/dashboard/models/dashboard_item.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final DashboardItem item;

  const AppBarWidget(
    this.item, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: item.color,
      leading: Icon(item.icon),
      title: Text(item.title),
      titleSpacing: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
