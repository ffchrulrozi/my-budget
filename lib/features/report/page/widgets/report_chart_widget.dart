import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ReportChartWidget extends StatelessWidget {
  const ReportChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, double> dataMap = {
      "Red": 10,
      "Orange": 30,
      "Green": 60,
    };
    
    return PieChart(
      centerText: "Income",
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 800),
      chartRadius: 180,
      colorList: const [Colors.red, Colors.orange, Colors.green],
      chartType: ChartType.ring,
      ringStrokeWidth: 30,
      chartValuesOptions: const ChartValuesOptions(
        showChartValuesInPercentage: false,
        showChartValues: false,
        showChartValueBackground: false,
      ),
      legendOptions: const LegendOptions(showLegends: false),
    );
  }
}
