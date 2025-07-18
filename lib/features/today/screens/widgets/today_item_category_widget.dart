import 'package:flutter/material.dart';
import 'package:my_budget/utils/helper/divider_helper.dart';

class TodayItemCategoryWidget extends StatelessWidget {
  const TodayItemCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <ItemCategory>[
      ItemCategory("All", false),
      ItemCategory("Income", false),
      ItemCategory("Outcome", false)
    ];

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Checkbox(
                value: items[index].isActive,
                onChanged: (val) => (),
              ),
              Text(items[index].title)
            ],
          );
        },
      ),
    );
  }
}

class ItemCategory {
  final String title;
  final bool isActive;

  ItemCategory(this.title, this.isActive);
}
