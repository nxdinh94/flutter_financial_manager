import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyAreaChart extends StatefulWidget {
  const MyAreaChart({super.key, required this.areaChartData});
  final List<ChartData> areaChartData;
  @override
  State<MyAreaChart> createState() => _MyAreaChartState();
}

class _MyAreaChartState extends State<MyAreaChart> {
  @override
  Widget build(BuildContext context) {

    final List<Color> color = <Color>[];
    color.add(Colors.green[50]!);
    color.add(Colors.green[200]!);
    color.add(secondaryColor);

    final List<double> stops = <double>[];
    stops.add(0.0);
    stops.add(0.5);
    stops.add(1.0);

    final LinearGradient gradientColors = LinearGradient(colors: color, stops: stops);

    return Container(
        height: 565,
        color: primaryColor,
        child: SfCartesianChart(
            isTransposed: true,
            title: ChartTitle(
              text: 'Biểu đồ chi tiêu',
              textStyle: Theme.of(context).textTheme.bodyLarge,
              alignment: ChartAlignment.near,
            ),
            primaryYAxis: NumericAxis(
              labelFormat: '{value}đ',
              title: AxisTitle(
                text: '(Đơn vị: Trăm nghìn)',
                alignment: ChartAlignment.far,
                textStyle: Theme.of(context).textTheme.labelMedium
              ),
            ),

            series: <CartesianSeries>[
              // Renders area chart
              AreaSeries<ChartData, int>(
                dataSource: widget.areaChartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                gradient: gradientColors,
              )
            ]
        )
    );
  }
}
class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}