import 'package:flutter/material.dart';
import 'package:my_budget/utils/helper/money_helper.dart';
import 'package:my_budget/utils/helper/style_helper.dart';
import 'package:intl/intl.dart';

class TodayTopScreen extends StatelessWidget {
  const TodayTopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
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
