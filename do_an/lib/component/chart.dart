/// dart import
/// Package import
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/spending.dart';

/// Local imports
/// Renders the chart with default trackball sample.
class LineChart extends StatelessWidget {
  /// Creates the chart with default trackball sample.
  const LineChart({Key? key, required this.spending}) : super(key: key);
  final List<Spending> spending;

  @override
  Widget build(BuildContext context) {
    return _buildInfiniteScrollingChart();
  }

  /// Returns the cartesian chart with default trackball.
  SfCartesianChart _buildInfiniteScrollingChart() {
    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(
          labelStyle: Get.textTheme.bodyText1!.copyWith(color: Colors.black),
          // majorTickLines: const MajorTickLines(color: Colors.red),
          majorGridLines: const MajorGridLines(width: 0),
          intervalType: DateTimeIntervalType.auto,
          dateFormat: DateFormat.yM()),
      primaryYAxis: NumericAxis(
          isVisible: false,
          labelStyle: Get.textTheme.bodyText1!.copyWith(color: Colors.black)),
      //can scroll
      zoomPanBehavior: ZoomPanBehavior(
        enablePanning: true,
      ),
      plotAreaBorderColor: Colors.black,
      series: getSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
      trackballBehavior: TrackballBehavior(
        shouldAlwaysShow: true,
        enable: true,
        activationMode: ActivationMode.none,
        tooltipSettings: const InteractiveTooltip(
            format: 'point.x : point.y', color: Colors.transparent),
      ),
    );
  }

  List<ChartSeries<Spending, DateTime>> getSeries() {
    return <ChartSeries<Spending, DateTime>>[
      SplineSeries<Spending, DateTime>(
        dataSource: spending,
        color: Colors.red,
        enableTooltip: true,
        xValueMapper: (sales, _) => sales.dateTime,
        yValueMapper: (sales, _) => sales.receive,
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          color: Colors.black,
          textStyle: Get.textTheme.bodyText1!.copyWith(color: Colors.white),
          labelPosition: ChartDataLabelPosition
              .outside, // Places the data labels outside the pie area
          // By setting the below property to none value, does not hides the data label that are getting hidden due to intersection
          labelIntersectAction: LabelIntersectAction.none,
        ),
      ),
      SplineSeries<Spending, DateTime>(
          dataSource: spending,
          color: Colors.green,
          enableTooltip: true,
          xValueMapper: (sales, _) => sales.dateTime,
          yValueMapper: (sales, _) => sales.pepper,
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              color: Colors.black,
              textStyle: Get.textTheme.bodyText1!.copyWith(color: Colors.white),
              labelPosition: ChartDataLabelPosition
                  .outside, // Places the data labels outside the pie area
              // By setting the below property to none value, does not hides the data label that are getting hidden due to intersection
              labelIntersectAction: LabelIntersectAction.none)),
    ];
  }
}
