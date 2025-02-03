import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PercentageLineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      margin: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,

      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Student Performance",
                  style: const TextStyle(
                    color: Color(0xff0F172A),
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 10,),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF1F5F9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  child: SizedBox(
                    width: 0.2,
                    height: 40,
                    child: DropdownButton<String>(
                      items: ["2020", "2021", "2022", "2023", "2024", "2025"]
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {},
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),

                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 32,
                          getTitlesWidget: (value, meta) {
                            if (value >= 1 && value <= 5) {
                              return Text((2019 + value.toInt()).toString());
                            }
                            return Container();
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        isCurved: true,
                        color: Colors.green,
                        barWidth: 2,
                        isStrokeCapRound: true,
                        dotData: FlDotData(show: true),
                        belowBarData: BarAreaData(show: false),
                        spots: const [
                          FlSpot(1, 1),
                          FlSpot(2, 1.5),
                          FlSpot(3, 1.4),
                          FlSpot(4, 2),
                          FlSpot(5, 2.2),
                        ],
                      ),
                      LineChartBarData(
                        isCurved: true,
                        color: Colors.pink,
                        barWidth: 2,
                        isStrokeCapRound: true,
                        dotData: FlDotData(show: true),
                        belowBarData: BarAreaData(show: false),
                        spots: const [
                          FlSpot(1, 1),
                          FlSpot(2, 2.8),
                          FlSpot(3, 1.7),
                          FlSpot(4, 2.4),
                          FlSpot(5, 2.2),
                        ],
                      ),
                      LineChartBarData(
                        isCurved: true,
                        color: Colors.cyan,
                        barWidth: 2,
                        isStrokeCapRound: true,
                        dotData: FlDotData(show: true),
                        belowBarData: BarAreaData(show: false),
                        spots: const [
                          FlSpot(1, 2.8),
                          FlSpot(2, 1.9),
                          FlSpot(3, 3),
                          FlSpot(4, 3.6),
                          FlSpot(5, 4),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

