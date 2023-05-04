// /// dart import
// /// Package import
// import 'package:flutter/material.dart';
// import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// /// Chart import
// import 'package:syncfusion_flutter_charts/charts.dart';

// import '../model/spending.dart';

// /// Local imports
// /// Renders the chart with default trackball sample.
// class LineChart extends StatelessWidget {
//   /// Creates the chart with default trackball sample.
//   const LineChart({Key? key, required this.spending}) : super(key: key);
//   final List<Spending> spending;

//   @override
//   Widget build(BuildContext context) {
//     return _buildInfiniteScrollingChart();
//   }

//   /// Returns the cartesian chart with default trackball.
//   SfCartesianChart _buildInfiniteScrollingChart() {
//     return SfCartesianChart(
//       primaryXAxis: DateTimeAxis(
//           labelStyle: Get.textTheme.bodyLarge!.copyWith(color: Colors.black),
//           // majorTickLines: const MajorTickLines(color: Colors.red),
//           majorGridLines: const MajorGridLines(width: 0),
//           intervalType: DateTimeIntervalType.auto,
//           dateFormat: DateFormat.yM()),
//       primaryYAxis: NumericAxis(
//           isVisible: false,
//           labelStyle: Get.textTheme.bodyLarge!.copyWith(color: Colors.black)),
//       //can scroll
//       zoomPanBehavior: ZoomPanBehavior(
//         enablePanning: true,
//       ),
//       plotAreaBorderColor: Colors.black,
//       series: getSeries(),
//       tooltipBehavior: TooltipBehavior(enable: true),
//       trackballBehavior: TrackballBehavior(
//         shouldAlwaysShow: true,
//         enable: true,
//         activationMode: ActivationMode.none,
//         tooltipSettings: const InteractiveTooltip(
//             format: 'point.x : point.y', color: Colors.transparent),
//       ),
//     );
//   }

//   List<ChartSeries<Spending, DateTime>> getSeries() {
//     return <ChartSeries<Spending, DateTime>>[
//       SplineSeries<Spending, DateTime>(
//         dataSource: spending,
//         color: Colors.red,
//         enableTooltip: true,
//         width: 3,
//         xValueMapper: (sales, _) => sales.dateTime,
//         yValueMapper: (sales, _) => sales.receive,
//         dataLabelMapper: (datum, index) => datum.receive.toString().toVND(),
//         dataLabelSettings: DataLabelSettings(
//           isVisible: true,
//           color: Colors.black,
//           textStyle: Get.textTheme.bodyLarge!.copyWith(color: Colors.white),
//           labelPosition: ChartDataLabelPosition
//               .outside, // Places the data labels outside the pie area
//           // By setting the below property to none value, does not hides the data label that are getting hidden due to intersection
//           labelIntersectAction: LabelIntersectAction.none,
//         ),
//       ),
//       SplineSeries<Spending, DateTime>(
//           dataSource: spending,
//           width: 3,
//           color: Colors.green,
//           enableTooltip: true,
//           xValueMapper: (sales, _) => sales.dateTime,
//           yValueMapper: (sales, _) => sales.pepper,
//           dataLabelMapper: (datum, index) => datum.pepper.toString().toVND(),
//           dataLabelSettings: DataLabelSettings(
//               isVisible: true,
//               color: Colors.black,
//               textStyle: Get.textTheme.bodyLarge!.copyWith(color: Colors.white),
//               labelPosition: ChartDataLabelPosition
//                   .outside, // Places the data labels outside the pie area
//               // By setting the below property to none value, does not hides the data label that are getting hidden due to intersection
//               labelIntersectAction: LabelIntersectAction.none)),
//     ];
//   }
// }

import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:decimal/decimal.dart';
import 'package:eval_ex/built_ins.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/spending.dart';

class BarChar extends StatefulWidget {
  final List<Spending> spending;

  const BarChar({Key? key, required this.spending}) : super(key: key);
  @override
  State<BarChar> createState() => _BarCharState();
}

class _BarCharState extends State<BarChar> {
  int touchGroupIndex = -1;
  List<Spending> viewSpending = [];
  double maxValueOfSpending = 0;
  @override
  void initState() {
    viewSpending = widget.spending
        .map((e) => Spending(
              dateTime: e.dateTime,
              pepper: e.pepper,
              receive: e.receive,
            ))
        .toList();
    touchGroupIndex = viewSpending.length - 1;
    super.initState();
  }

  void handleTouchEvent(FlTouchEvent event, BarTouchResponse? touchResponse) {
    if (event is FlTapDownEvent) {
      if (touchResponse != null && touchResponse.spot != null) {
        touchGroupIndex =
            touchResponse.spot?.touchedBarGroupIndex ?? touchGroupIndex;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: BarChart(
        BarChartData(
          extraLinesData: ExtraLinesData(horizontalLines: [
            // HorizontalLine(y: y),
          ]),
          borderData: FlBorderData(
            border: const Border(
              bottom: BorderSide(
                color: Colors.black,
              ),
              left: BorderSide(
                color: Colors.black,
              ),
            ),
          ),
          barTouchData: BarTouchData(
              touchCallback: handleTouchEvent,
              enabled: false,
              touchTooltipData: BarTouchTooltipData(
                tooltipPadding: const EdgeInsets.all(0),
                tooltipMargin: 0,
                tooltipBgColor: Colors.transparent,
                getTooltipItem: (group, groupIndex, rod, rodIndex) =>
                    BarTooltipItem(
                  rod.toY.short(),
                  Get.textTheme.bodyText1!,
                ),
              )),
          barGroups: barChartGroupData(),
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) =>
                FlLine(dashArray: [8], color: Colors.grey.withOpacity(0.9)),
          ),
          titlesData: buildTitle(),
        ),
        swapAnimationDuration: const Duration(
          milliseconds: 1000,
        ), // Optional
        swapAnimationCurve: Curves.linearToEaseOut, // Optional
      ),
    ).paddingAll(12);
  }

  List<BarChartGroupData> barChartGroupData() {
    return List.generate(
      widget.spending.length,
      (index) => buildChartGroup(index, viewSpending[index]),
    );
  }

  BarChartGroupData buildChartGroup(
    int index,
    Spending spending,
  ) {
    bool isToucher = (touchGroupIndex == -1) || index == touchGroupIndex;
    return BarChartGroupData(
        x: index,
        barsSpace: 5,
        showingTooltipIndicators: isToucher ? [0, 1] : [],
        barRods: [
          buildBarChartRodData(
            spending.receive.toDouble(),
            isTouch: true,
          ),
          buildBarChartRodData(
            spending.pepper.toDouble(),
            colorColumn: Colors.green,
            isTouch: true,
          ),
        ]);
  }

  BarChartRodData buildBarChartRodData(double yValue,
      {bool isTouch = true, Color colorColumn = Colors.red}) {
    return BarChartRodData(
      toY: yValue,
      color: isTouch ? colorColumn : Colors.grey,
      width: 20,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4), topRight: Radius.circular(4)),
    );
  }

  FlTitlesData buildTitle() {
    return FlTitlesData(
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            DateTime dateTime = viewSpending[value.toInt()].dateTime;
            return AutoSizeText(DateFormat.yM().format(dateTime));
          },
        )),
        leftTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: (value, meta) {
            return AutoSizeText(
              value.short(),
              style: Get.textTheme.subtitle1!.copyWith(
                fontSize: 8,
              ),
            );
          },
        )),
        rightTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: false,
        )),
        topTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: false,
        )));
  }
}

extension ShortNumber on double {
  String short() {
    if (this == 0) {
      return "0";
    }
    int index = (Decimal.parse((log10(this) / 3).toStringAsFixed(1)).floor())
        .toDouble()
        .toInt();
    String floor = (this / pow(10, index * 3)).toStringAsFixed(1);
    return "$floor${mapShortValue[index]}";
  }
}

Map<int, String> mapShortValue = {
  1: "K",
  2: "M",
  3: "B",
};
