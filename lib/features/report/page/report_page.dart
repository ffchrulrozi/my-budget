import 'package:flutter/material.dart';
import 'package:my_budget/features/dashboard/models/dashboard_page_setting.dart';
import 'package:my_budget/features/report/page/widgets/report_chart_widget.dart';
import 'package:my_budget/features/report/page/widgets/report_item_widget.dart';
import 'package:my_budget/functions/show_date_filter.dart';
import 'package:my_budget/utils/helper/divider_helper.dart';
import 'package:my_budget/utils/helper/money_helper.dart';
import 'package:my_budget/utils/helper/style_helper.dart';

class ReportPage extends StatelessWidget {
  final DashboardPageSetting pageSetting;
  const ReportPage({required this.pageSetting, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageSetting.color,
      appBar: AppBar(
        backgroundColor: pageSetting.color,
        leading: Icon(pageSetting.icon),
        title: Text(pageSetting.title),
        titleSpacing: 0,
        actions: [
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
        ],
      ),
      body: Column(
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text("20 Jun - 19 Jul 2025"),
                      v(1),
                      Divider(),
                      v(3),
                      ReportChartWidget(),
                      v(3),
                      ReportItemWidget(),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
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
  const TopBox({
    required this.label,
    required this.value,
    required this.crossAxisAlignment,
    super.key,
  });

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
