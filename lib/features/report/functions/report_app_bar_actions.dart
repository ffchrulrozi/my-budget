import 'package:flutter/material.dart';
import 'package:my_budget/functions/show_date_filter.dart';
import 'package:my_budget/utils/helper/divider_helper.dart';

List<Widget> reportAppBarActions(BuildContext context) {
  return [
    InkWell(
      onTap: () => showDateFilter(context),
      child: Row(
        children: [
          Text("This Week"),
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
      items: ['Income', 'Outcome']
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
      selectedItemBuilder: (context) => ['Income', 'Outcome']
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
