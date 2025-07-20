import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_budget/utils/helper/style_helper.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

void showDateFilter(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: SizedBox(
          height: 400,
          child: SfDateRangePicker(
            navigationDirection: DateRangePickerNavigationDirection.vertical,
            showNavigationArrow: true,
            enablePastDates: true,
            backgroundColor: Colors.white,
            todayHighlightColor: Colors.teal,
            onCancel: () => context.pop(),
            onSubmit: (val) => context.pop(),
            cellBuilder: (context, details) {
              return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      details.date.day.toString(),
                      style: text(context).bodyLarge,
                    ),
                    Text(
                      "2.6jt",
                      style: text(context).labelSmall,
                    )
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
