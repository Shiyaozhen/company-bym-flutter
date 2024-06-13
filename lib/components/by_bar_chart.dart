import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ByBarChart extends StatelessWidget {
  final List data;

  const ByBarChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.only(top: 60),
      child: BarChart(
        BarChartData(
          // 数据
          barGroups: <BarChartGroupData>[
            for (int i = 0; i < data.length; i++)
              BarChartGroupData(
                x: i,
                barRods: <BarChartRodData>[
                  BarChartRodData(
                    toY: data[i]['y'],
                    color: const Color(0xFF5475F7),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                ],
              ),
          ],
          // 标题
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(data[value.toInt()]['x'].toString()),
                  );
                },
                reservedSize: 40,
              ),
            ),
          ),
          // 网格
          gridData: FlGridData(
            drawVerticalLine: false,
            getDrawingHorizontalLine: (double value) {
              return const FlLine(
                color: Color(0xFFC9C9C9),
                strokeWidth: 0.4,
                dashArray: [1, 2],
              );
            },
          ),
          // 边框
          borderData: FlBorderData(
            border: const Border(
              bottom: BorderSide(color: Color(0xFFC9C9C9)),
            ),
          ),
        ),
        swapAnimationDuration: const Duration(milliseconds: 150),
        swapAnimationCurve: Curves.linear,
      ),
    );
  }
}

