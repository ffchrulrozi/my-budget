import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_budget/features/dashboard/models/dashboard_page_setting.dart';
import 'package:my_budget/features/report/bloc/report_bloc.dart';
import 'package:my_budget/features/report/bloc/report_event.dart';
import 'package:my_budget/features/report/bloc/report_state.dart';
import 'package:my_budget/features/report/page/widgets/report_chart_widget.dart';
import 'package:my_budget/utils/ext/date_ext.dart';
import 'package:my_budget/utils/helper/divider_helper.dart';
import 'package:my_budget/utils/helper/number_helper.dart';
import 'package:my_budget/utils/helper/style_helper.dart';

class ReportPage extends StatelessWidget {
  final DashboardPageSetting pageSetting;
  const ReportPage({required this.pageSetting, super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ReportBloc>();
    final state = bloc.state;
    String dateNote = "";
    final dateTypes = [
      FilterDateType.TODAY,
      FilterDateType.LAST7DAYS,
      FilterDateType.THISMONTH,
      FilterDateType.LAST30DAYS,
      FilterDateType.CUSTOM
    ];

    String formatDate(String format, DateTime date) =>
        DateFormat(format).format(date);

    if (state.filter != null) {
      DateTime startDate = state.filter!.startDate!;
      DateTime endDate = state.filter!.endDate!.toStartOfDay();

      if (startDate == endDate) {
        dateNote = formatDate("dd-MMM-yyyy", startDate);
      } else {
        if (startDate.year == endDate.year) {
          if (startDate.month == endDate.month) {
            dateNote =
                "${formatDate("dd", startDate)} - ${formatDate("dd", endDate)} ${formatDate("MMM-yyyy", startDate)}";
          } else {
            dateNote =
                "${formatDate("dd-MMM", startDate)} - ${formatDate("dd-MMM", endDate)} ${formatDate("yyyy", startDate)}";
          }
        } else {
          dateNote =
              "${formatDate("dd-MMM-yyyy", startDate)} - ${formatDate("dd-MMM-yyyy", endDate)}";
        }
      }
    }

    return Scaffold(
      backgroundColor: pageSetting.color,
      appBar: AppBar(
        backgroundColor: pageSetting.color,
        leading: Icon(pageSetting.icon),
        title: Text(pageSetting.title),
        titleSpacing: 0,
        actions: [
          DropdownButton<String>(
            alignment: Alignment.centerRight,
            value: state.filter?.dateType,
            style: TextStyle(textBaseline: TextBaseline.alphabetic),
            iconEnabledColor: Colors.white,
            underline: Container(),
            items: dateTypes
                .map(
                  (dateType) => DropdownMenuItem(
                    value: dateType,
                    child: Text(
                      dateType,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
                .toList(),
            onChanged: (val) {
              if (val == FilterDateType.CUSTOM) {
              } else {
                bloc.add(FilterChange(dateType: val));
              }
            },
            selectedItemBuilder: (context) => dateTypes
                .map(
                  (dateType) => DropdownMenuItem(
                    value: dateType,
                    child: Text(
                      dateType,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
                .toList(),
          ),
          h(2),
          DropdownButton<int>(
            alignment: Alignment.centerRight,
            value: state.filter?.typeId,
            style: TextStyle(textBaseline: TextBaseline.alphabetic),
            iconEnabledColor: Colors.white,
            underline: Container(),
            items: state.types
                .map(
                  (type) => DropdownMenuItem(
                    value: type.id,
                    child: Text(
                      type.name,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
                .toList(),
            onChanged: (val) => bloc.add(FilterChange(typeId: val)),
            selectedItemBuilder: (context) => state.types
                .map(
                  (type) => DropdownMenuItem(
                    value: type.id,
                    child: Text(
                      type.name,
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
                  value: state.summary?.income ?? 0,
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                TopBox(
                  label: "Outcome Amount",
                  value: state.summary?.outcome ?? 0,
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
                      Text(dateNote),
                      v(1),
                      Divider(),
                      v(3),
                      state.categories.isEmpty
                          ? Container()
                          : ReportChartWidget(state),
                      v(3),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          var item = state.categories[index];

                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              children: [
                                if (item.icon != null)
                                  Icon(IconData(
                                    item.icon!,
                                    fontFamily: 'MaterialIcons',
                                  )),
                                h(2),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.categoryName ?? "",
                                      style: text(context).bodyLarge,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(Rupiah(item.amount ?? 0),
                                        style: text(context).titleMedium!),
                                    Text(
                                      Percent(item.percent),
                                      style: text(context).bodyMedium!.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
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
