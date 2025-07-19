import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_budget/utils/helper/style_helper.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ReportTopCalendarWidget extends StatelessWidget {
  const ReportTopCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SfDateRangePicker(
      showActionButtons: true,
      selectionMode: DateRangePickerSelectionMode.extendableRange,
      navigationDirection: DateRangePickerNavigationDirection.vertical,
      showNavigationArrow: true,
      enablePastDates: true,
      backgroundColor: Colors.white,
      todayHighlightColor: Colors.teal,
      startRangeSelectionColor: Colors.blue,
      endRangeSelectionColor: Colors.blue,
      rangeSelectionColor: Color.fromARGB(10, 0, 0, 0),
      minDate: DateTime.now(),
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
    );
  }
}
