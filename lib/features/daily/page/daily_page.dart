import 'package:flutter/material.dart';
import 'package:my_budget/features/daily/page/widgets/daily_item_widget.dart';
import 'package:my_budget/utils/helper/money_helper.dart';
import 'package:my_budget/utils/helper/style_helper.dart';

class DailyPage extends StatelessWidget {
  const DailyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TopBox(
                label: "Income Amount",
                value: 12000000,
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              TopBox(
                label: "Outcome Amount",
                value: 2560000,
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: DailyItemWidget(),
            ),
          ),
        )
      ],
    );
  }
}

class TabItem {
  final String label;
  final IconData icon;

  TabItem(this.label, this.icon);
}

class TopBox extends StatelessWidget {
  final String label;
  final int value;
  final CrossAxisAlignment crossAxisAlignment;
  const TopBox(
      {required this.label,
      required this.value,
      required this.crossAxisAlignment,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          label,
          style: text(context).bodyMedium!.copyWith(color: Colors.white),
        ),
        Text(
          Rupiah(value),
          style: text(context).titleLarge!.copyWith(color: Colors.white),
        )
      ],
    );
  }
}
