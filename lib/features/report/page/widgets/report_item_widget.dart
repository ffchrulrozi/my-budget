import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_budget/features/report/models/item.dart';
import 'package:my_budget/widgets/item_widget.dart';

class ReportItemWidget extends StatelessWidget {
  const ReportItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <Item>[
      Item(
        type: ItemType.OUTCOME,
        icon: FontAwesomeIcons.bus,
        title: "Transportation",
        desc: "Ojek",
        amount: 20000,
        percent: 20,
      ),
      Item(
        type: ItemType.OUTCOME,
        icon: FontAwesomeIcons.bus,
        title: "Transportation",
        desc: "Ojek",
        amount: 20000,
        percent: 20,
      ),
      Item(
        type: ItemType.OUTCOME,
        icon: FontAwesomeIcons.bus,
        title: "Transportation",
        desc: "Ojek",
        amount: 20000,
        percent: 20,
      ),
      Item(
        type: ItemType.INCOME,
        icon: FontAwesomeIcons.moneyBill,
        title: "THR",
        desc: "THR Lebaran",
        amount: 20000,
        percent: 20,
      ),
      Item(
        type: ItemType.OUTCOME,
        icon: FontAwesomeIcons.bus,
        title: "Transportation",
        desc: "Ojek",
        amount: 20000,
        percent: 20,
      ),
      Item(
        type: ItemType.OUTCOME,
        icon: FontAwesomeIcons.bus,
        title: "Transportation",
        desc: "Ojek",
        amount: 20000,
        percent: 20,
      ),
      Item(
        type: ItemType.OUTCOME,
        icon: FontAwesomeIcons.bus,
        title: "Transportation",
        desc: "Ojek",
        amount: 20000,
        percent: 20,
      ),
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) => ItemWidget(items[index]),
    );
  }
}
