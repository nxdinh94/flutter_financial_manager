import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyColumnChart extends StatefulWidget {
  const MyColumnChart({Key? key, required this.data}) : super(key: key);
  final List<ColumnChartModel>data;
  @override
  State<MyColumnChart> createState() => _MyColumnChartState();
}

class _MyColumnChartState extends State<MyColumnChart> {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      margin: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 6),
      enableAxisAnimation: true,
      primaryXAxis: const NumericAxis(
        axisLine: AxisLine(width: 0),
        majorTickLines: MajorTickLines(width: 0),
        majorGridLines: MajorGridLines(width: 0),
        isVisible: false,
      ),
      primaryYAxis: const NumericAxis(
        majorGridLines: MajorGridLines(
            width: 0
        ),
        isVisible: false, // Hide Y-axis

      ),

      series: <CartesianSeries<ColumnChartModel, int>>[
        // Renders column chart
        ColumnSeries<ColumnChartModel, int>(
          dataSource: widget.data,
          xValueMapper: (ColumnChartModel data, _) => data.x,
          yValueMapper: (ColumnChartModel data, _) => data.y,
          width: 0.7,
          spacing: 0,
          trackPadding: 0,
          pointColorMapper: (ColumnChartModel data, _) => data.color, // Set column color
          isTrackVisible: false,
          dataLabelSettings: const DataLabelSettings(isVisible: false),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),topRight: Radius.circular(5)
          ),
        )
      ],
      // backgroundColor: Colors.yellowAccent,
    );
  }
}
class ColumnChartModel {
  ColumnChartModel(this.x, this.y, this.color);
  final int x;
  final double y;
  final Color color;
}
