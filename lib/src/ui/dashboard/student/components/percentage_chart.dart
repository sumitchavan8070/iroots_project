import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PercentageLineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: LineChart(
        LineChartData(
          gridData:  FlGridData(show: false),
          baselineX: 20,
          baselineY: 100,
          titlesData:  FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false, // Hides the left axis titles
                reservedSize: 40,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false, // Hides the bottom axis titles
                reservedSize: 32,
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 70),
                const FlSpot(1, 60),
                const FlSpot(2, 80),
              ],
              isCurved: true,
              color: Colors.blue,
              barWidth: 3,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(show: false),
            ),
            LineChartBarData(
              spots: [
                const FlSpot(0, 50),
                const FlSpot(1, 40),
                const FlSpot(2, 60),
              ],
              isCurved: true,
              color: Colors.red,
              barWidth: 3,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(show: false),
            ),
            LineChartBarData(
              spots: [
                const FlSpot(0, 40),
                const FlSpot(1, 50),
                const FlSpot(2, 30),
              ],
              isCurved: true,
              color: Colors.green,
              barWidth: 3,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(show: false),
            ),
            LineChartBarData(
              spots: [
                const FlSpot(0, 60),
                const FlSpot(1, 70),
                const FlSpot(2, 50),
              ],
              isCurved: true,
              color: Colors.orange,
              barWidth: 3,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
