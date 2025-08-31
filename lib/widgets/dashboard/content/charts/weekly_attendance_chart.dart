import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WeeklyAttendanceChart extends StatelessWidget {
  const WeeklyAttendanceChart({super.key});

  // Datos de asistencia vs ausencias por día
  final List<AttendanceData> _attendanceData = const [
    AttendanceData(day: "Lun", attended: 14, missed: 2, rate: 87.5),
    AttendanceData(day: "Mar", attended: 17, missed: 1, rate: 94.4),
    AttendanceData(day: "Mié", attended: 19, missed: 1, rate: 95.0),
    AttendanceData(day: "Jue", attended: 15, missed: 2, rate: 88.2),
    AttendanceData(day: "Vie", attended: 14, missed: 1, rate: 93.3),
    AttendanceData(day: "Sáb", attended: 8, missed: 1, rate: 88.9),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                // Línea de asistencias
                LineChartBarData(
                  spots: _attendanceData.asMap().entries.map((entry) => 
                    FlSpot(entry.key.toDouble(), entry.value.attended.toDouble())
                  ).toList(),
                  isCurved: true,
                  color: const Color(0xFF10B981),
                  barWidth: 3,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(77, 16, 185, 129), // 0xFF10B981 with 0.3 alpha
                        Color.fromARGB(13, 16, 185, 129), // 0xFF10B981 with 0.05 alpha
                      ],
                    ),
                  ),
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) => 
                      FlDotCirclePainter(
                        radius: 4, 
                        color: const Color(0xFF10B981), 
                        strokeWidth: 2, 
                        strokeColor: Colors.white
                      )
                  ),
                ),
                // Línea de ausencias
                LineChartBarData(
                  spots: _attendanceData.asMap().entries.map((entry) => 
                    FlSpot(entry.key.toDouble(), entry.value.missed.toDouble())
                  ).toList(),
                  isCurved: true,
                  color: const Color(0xFFEF4444),
                  barWidth: 3,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) => 
                      FlDotCirclePainter(
                        radius: 3, 
                        color: const Color(0xFFEF4444), 
                        strokeWidth: 2, 
                        strokeColor: Colors.white
                      )
                  ),
                ),
              ],
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 35,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      int index = value.toInt();
                      if (index >= 0 && index < _attendanceData.length) {
                        return Text(
                          _attendanceData[index].day,
                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                        );
                      }
                      return const Text('');
                    },
                  ),
                ),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.grey.withValues(alpha: 0.2),
                  strokeWidth: 1,
                ),
              ),
              maxY: 25,
              lineTouchData: LineTouchData(enabled: false),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem("Asistieron", const Color(0xFF10B981)),
              const SizedBox(width: 20),
              _buildLegendItem("Faltaron", const Color(0xFFEF4444)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 3,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }
}

class AttendanceData {
  final String day;
  final int attended;
  final int missed;
  final double rate;

  const AttendanceData({
    required this.day, 
    required this.attended, 
    required this.missed, 
    required this.rate
  });
}