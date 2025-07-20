import 'package:flutter/material.dart';
import 'package:my_budget/functions/show_date_filter.dart';
import 'package:my_budget/utils/helper/divider_helper.dart';

List<Widget> dailyAppBarActions(BuildContext context) {
  return [
    InkWell(
      onTap: () => showDateFilter(context),
      child: Row(
        children: [
          Text("19 Jun 2025"),
          Icon(Icons.arrow_drop_down),
        ],
      ),
    ),
    h(2),
    DropdownButton<String>(
      alignment: Alignment.centerRight,
      value: 'Income',
      style: TextStyle(textBaseline: TextBaseline.alphabetic),
      iconEnabledColor: Colors.white,
      underline: Container(),
      items: ['All', 'Income', 'Outcome']
          .map(
            (option) => DropdownMenuItem(
              value: option,
              child: Text(
                option,
                style: TextStyle(color: Colors.black),
              ),
            ),
          )
          .toList(),
      onChanged: (val) => (),
      selectedItemBuilder: (context) => ['All', 'Income', 'Outcome']
          .map(
            (option) => DropdownMenuItem(
              value: option,
              child: Text(
                option,
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
          .toList(),
    ),
    h(1),
  ];
}
