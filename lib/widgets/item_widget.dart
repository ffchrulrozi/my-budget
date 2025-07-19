import 'package:flutter/material.dart';
import 'package:my_budget/features/report/models/item.dart';
import 'package:my_budget/utils/helper/divider_helper.dart';
import 'package:my_budget/utils/helper/number_helper.dart';
import 'package:my_budget/utils/helper/style_helper.dart';

class ItemWidget extends StatelessWidget {
  final Item item;
  const ItemWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Icon(item.icon),
          h(2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: text(context).bodyLarge,
              ),
              Text(
                item.desc,
                style: text(context).bodyMedium,
              ),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                Rupiah(item.amount),
                style: text(context).titleMedium!.copyWith(
                    color: item.type == ItemType.OUTCOME
                        ? Colors.red
                        : Colors.teal),
              ),
              Text(
                Percent(item.percent),
                style: text(context).bodyMedium!.copyWith(
                      color: item.type == ItemType.OUTCOME
                          ? Colors.red
                          : Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
              )
            ],
          )
        ],
      ),
    );
  }
}
