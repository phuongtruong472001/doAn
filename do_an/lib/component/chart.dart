import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//Color test
//MultiLine chart

List<Color> gradientColors = [
  const Color(0xFFE80054),
  const Color(0xFF50E4FF),
];

class WeatherChart2 extends StatelessWidget {
  const WeatherChart2({Key? key, required this.currentWeather})
      : super(key: key);
  final List<int> currentWeather;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      width: Get.width,
      child: LineChart(
        lineCharData,
        swapAnimationDuration: const Duration(
          milliseconds: 150,
        ),
        swapAnimationCurve: Curves.linear,
      ),
    );
  }

  //LineCharData
  LineChartData get lineCharData {
    List<double> xValues = spot1().map((e) => e.x).toList();
    List<double> yValues = spot1().map((e) => e.y).toList();
    xValues.sort(
      (a, b) => a.compareTo(b),
    );
    yValues.sort(
      (a, b) => a.compareTo(b),
    );

    final double minX = xValues.first;
    final double minY = yValues.first;
    final double maxX = xValues.last;
    final double maxY = yValues.last;
    final showToolTipsIndex = spot1().map((e) => e.x.toInt()).toList();

    return LineChartData(
      //Danh sách các đối tượng được thể hiện trên đồ thị
      lineBarsData: listLineCharBarData,
      backgroundColor: Colors.transparent,
      //Các giá trị này có thể set theo giá trị đầu vào của spots
      minX: minX,
      maxX: maxX,
      maxY: maxY * 1.4,
      minY: 0,
      // clipData: FlClipData.all(),
      //Cấu hình hiển thị lưới trong đồ thị
      gridData: FlGridData(
        show: false,
      ),
      //Hiển thị dữ liệu tương ứng trên đồ thị ( giá trị của trục Y )
      showingTooltipIndicators: showToolTipsIndex
          .map((element) => ShowingTooltipIndicators([
                LineBarSpot(
                  lineChartBarData1,
                  listLineCharBarData.indexOf(lineChartBarData1),
                  lineChartBarData1.spots[element],
                )
              ]))
          .toList(),
      //Cấu hình border xung quanh đồ thị
      borderData: FlBorderData(show: false, border: const Border()),
      lineTouchData: LineTouchData(
        enabled: true,
        //set false để luôn luôn hiển thị trên đồ thị
        handleBuiltInTouches: false,
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((index) {
            return TouchedSpotIndicatorData(
              //Đường thể hiện hình chiếu vuông góc với trục X
              FlLine(
                color: Colors.transparent,
              ),
              //Cấu hình hình dạng của các điểm trên đồ thị
              FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  color: Colors.black,
                  radius: 3,
                  strokeWidth: 0.4,
                  strokeColor: Colors.white,
                ),
              ),
            );
          }).toList();
        },
        //Cấu hình widget thể hiện cho dữ liệu
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipRoundedRadius: 8,
          tooltipPadding: EdgeInsets.zero,
          getTooltipItems: (List<LineBarSpot> lineBarsSpot) => lineBarsSpot
              .map((lineBarSpot) => LineTooltipItem(
                    lineBarSpot.y.toString(),
                    Get.textTheme.bodyText1!.copyWith(color: Colors.black),
                  ))
              .toList(),
        ),
      ),
      //Cấu hình tiêu đề cho các cột.
      titlesData: setTitleChart,
      // betweenBarsData: listBetweenBarsData,
    );
  }

  //Danh sách biểu đồ được thể hiện trên đồ thị
  List<LineChartBarData> get listLineCharBarData => [
        lineChartBarData1,
        lineChartBarData2,
        // lineChartBarData3,
      ];

  LineChartBarData get lineChartBarData1 {
    final showToolTipsIndex = spot1().map((e) => e.x.toInt()).toList();
    return LineChartBarData(
      barWidth: 2,
      shadow: const BoxShadow(
          color: Colors.white,
          blurRadius: 4,
          spreadRadius: 1.3,
          offset: Offset(0, -3)),
      spots: spot1(),
      color: Colors.green,
      isCurved: true,
      curveSmoothness: 0.4,
      showingIndicators: showToolTipsIndex,
      dotData: FlDotData(
        show: false,
      ),
    );
  }

  LineChartBarData get lineChartBarData2 {
    final showToolTipsIndex = spot2().map((e) => e.x.toInt()).toList();
    return LineChartBarData(
      barWidth: 2,
      shadow: const BoxShadow(
          color: Colors.white,
          blurRadius: 4,
          spreadRadius: 1.3,
          offset: Offset(0, -3)),
      spots: spot2(),
      color: Colors.red,
      isCurved: true,
      curveSmoothness: 0.4,
      showingIndicators: showToolTipsIndex,
      dotData: FlDotData(
        show: false,
      ),
    );
  }

  //FlSpotData
  List<FlSpot> spot1() {
    return [
      for (int i = 0; i < currentWeather.length; i++)
        FlSpot(i.toDouble(), currentWeather[i].toDouble())
    ];
  }

  List<FlSpot> spot2() {
    return [
      for (int i = 0; i < currentWeather.length; i++)
        FlSpot(i.toDouble(), currentWeather[i].toDouble() + 1000)
    ];
  }

  FlTitlesData get setTitleChart => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles(),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        leftTitles: AxisTitles(
          axisNameSize: 20,
          // axisNameWidget: Text(
          //   'Cột',
          //   style: Get.textTheme.bodyText1,
          // ),
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      );

  SideTitles leftTitle() {
    return SideTitles(
      showTitles: false,
      reservedSize: 24,
      getTitlesWidget: (value, meta) => SideTitleWidget(
        axisSide: meta.axisSide,
        angle: 0,
        child: Text(
          value.toInt().toString(),
          style: Get.textTheme.bodyText2,
        ),
      ),
    );
  }

  SideTitles bottomTitles() {
    return SideTitles(
      showTitles: true,
      reservedSize: 24,
      getTitlesWidget: (value, meta) => SideTitleWidget(
        axisSide: meta.axisSide,
        angle: 0,
        child: Text(
          value.toInt().toString(),
          style: Get.textTheme.bodyText2,
        ),
      ),
    );
  }
}
