import 'package:fe_financial_manager/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
class MyPieChart extends StatelessWidget {
  Map<String, double> dataMap;
  final bool isShowLegend;
  final bool isShowPercentageValue;
  final bool isShowChartValue;
  final double height;
  MyPieChart({
    Key? key,
    required this.dataMap,
    this.isShowLegend = true,
    this.isShowPercentageValue = false,
    this.isShowChartValue = false,
    this.height =200
  }) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: PieChart(
        dataMap: dataMap,
        animationDuration: const Duration(milliseconds: 1500),
        chartLegendSpacing: 80,
        chartRadius: MediaQuery.of(context).size.width / 3.2,
        initialAngleInDegree: 0,
        chartType: ChartType.ring,
        ringStrokeWidth: 50,
        // centerText: "HYBRID",
        colorList: pieChartColorList,
        // Pass gradient to PieChart
        emptyColorGradient: const [
          Color(0xff6c5ce7),
          Colors.blue,
        ],

        legendOptions: LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
          showLegends: isShowLegend,
          legendShape: BoxShape.circle,
          legendTextStyle:const TextStyle(
            color: colorTextLabel,
          ),

        ),

        chartValuesOptions:  ChartValuesOptions(
            showChartValueBackground: true,
            showChartValues: isShowChartValue,
            chartValueBackgroundColor: Colors.transparent,
            showChartValuesInPercentage: isShowPercentageValue,
            showChartValuesOutside: false,
            decimalPlaces: 2,
            chartValueStyle: const TextStyle(color: colorTextBlack)
        ),

      ),
    );
  }
}