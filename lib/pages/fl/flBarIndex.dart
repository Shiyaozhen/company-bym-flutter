import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FlBarindex extends StatefulWidget {
  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<FlBarindex> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            width: 300,
            height: 300,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Color(0xff232d37)),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 12.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                mainData(),
              ),
            ),
          ),
          const Positioned(
            top: 5,
            left: 5,
            child: Text(
              '访问量',
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  decoration: TextDecoration.none),
            ),
          )
        ],
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 22,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return Text(meta.formattedValue + '月',
                      style: TextStyle(
                          color: Color(0xff68737d),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          decoration: TextDecoration.none));
                })),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (double value, TitleMeta meta) {
              return Text(meta.formattedValue,
                  style: TextStyle(
                      color: Color(0xff68737d),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      decoration: TextDecoration.none));
            },
            reservedSize: 28,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 1,
      maxX: 12,
      minY: 0,
      maxY: 6,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(1, 3),
        FlSpot(2, 2),
        FlSpot(3, 5),
        FlSpot(4, 3.1),
        FlSpot(5, 4),
        FlSpot(6, 3),
        FlSpot(7, 4),
        FlSpot(8, 4),
        FlSpot(9, 4),
        FlSpot(10, 4),
        FlSpot(11, 4),
        FlSpot(12, 4),
      ],
      isCurved: true,
      // colors: gradientColors,
      barWidth: 5,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: true,
        // colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
      ),
    );
    return [lineChartBarData1];
  }
}
