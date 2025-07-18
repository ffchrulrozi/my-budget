import 'package:flutter/material.dart';
import 'package:my_budget/features/today/screens/widgets/today_item_category_widget.dart';
import 'package:my_budget/features/today/screens/widgets/today_item_widget.dart';

class TodayBodyScreen extends StatelessWidget {
  const TodayBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          TodayItemCategoryWidget(),
          Divider(),
          Expanded(
            child: TodayItemWidget(),
          )
        ],
      ),
    );
  }
}
