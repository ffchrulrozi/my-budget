import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_budget/features/report/bloc/report_state.dart';
import 'package:pie_chart/pie_chart.dart';

class ReportChartWidget extends StatelessWidget {
  final ReportState state;
  const ReportChartWidget(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      for (var item in state.categories) item.categoryName!: item.avg!
    };

    List<Color> colors = [
      Colors.red,
      Colors.orange,
      Colors.green,
      Colors.blue,
      Colors.purple,
      Colors.teal,
      Colors.blueGrey,
      Colors.indigoAccent,
      Colors.yellow,
      Colors.brown,
    ];
    List<Color> colorList() => colors.sublist(0, state.categories.length);

    return PieChart(
      centerText: state.filter?.typeId == 1 ? "outcome".tr() : "income".tr(),
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 1000),
      chartRadius: 180,
      colorList: colorList(),
      chartType: ChartType.ring,
      ringStrokeWidth: 30,
      chartValuesOptions: const ChartValuesOptions(
        showChartValuesInPercentage: false,
        showChartValues: false,
        showChartValueBackground: false,
      ),
      legendOptions: const LegendOptions(
        showLegends: true,
        showLegendsInRow: true,
        legendPosition: LegendPosition.bottom,
      ),
    );
  }
}
