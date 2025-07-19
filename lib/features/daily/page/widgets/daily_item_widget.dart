import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_budget/features/daily/models/item.dart';
import 'package:my_budget/utils/helper/divider_helper.dart';
import 'package:my_budget/utils/helper/money_helper.dart';
import 'package:my_budget/utils/helper/style_helper.dart';

class DailyItemWidget extends StatelessWidget {
  const DailyItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <Item>[
      Item(
        type: ItemType.OUTCOME,
        icon: FontAwesomeIcons.bus,
        title: "Transportation",
        desc: "Ojek",
        amount: 20000,
      ),
      Item(
        type: ItemType.OUTCOME,
        icon: FontAwesomeIcons.bus,
        title: "Transportation",
        desc: "Ojek",
        amount: 20000,
      ),
      Item(
        type: ItemType.OUTCOME,
        icon: FontAwesomeIcons.bus,
        title: "Transportation",
        desc: "Ojek",
        amount: 20000,
      ),
      Item(
        type: ItemType.INCOME,
        icon: FontAwesomeIcons.moneyBill,
        title: "THR",
        desc: "THR Lebaran",
        amount: 20000,
      ),
      Item(
        type: ItemType.OUTCOME,
        icon: FontAwesomeIcons.bus,
        title: "Transportation",
        desc: "Ojek",
        amount: 20000,
      ),
    ];

    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

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
                  Text(item.desc),
                ],
              ),
              Spacer(),
              Text(
                Rupiah(item.amount),
                style: text(context).titleMedium!.copyWith(
                    color: item.type == ItemType.OUTCOME
                        ? Colors.red
                        : Colors.teal),
              )
            ],
          ),
        );
      },
    );
  }
}
