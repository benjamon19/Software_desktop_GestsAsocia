import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PatientGrowthChart extends StatelessWidget {
  const PatientGrowthChart({super.key});

  // Datos ficticios realistas para una clínica dental
  final List<FlSpot> _patientData = const [
    FlSpot(0, 1180), // Enero
    FlSpot(1, 1205), // Febrero
    FlSpot(2, 1234), // Marzo
    FlSpot(3, 1260), // Abril
    FlSpot(4, 1275), // Mayo
    FlSpot(5, 1284), // Junio (actual)
  ];

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: _patientData,
            isCurved: true,
            color: const Color(0xFF4299E1),
            barWidth: 4,
            belowBarData: BarAreaData(
              show: true, 
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(77, 66, 153, 225), // 0xFF4299E1 with 0.3 alpha
                  Color.fromARGB(26, 66, 153, 225), // 0xFF4299E1 with 0.1 alpha
                ],
              ),
            ),
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) => 
                FlDotCirclePainter(
                  radius: 5, 
                  color: const Color(0xFF4299E1), 
                  strokeWidth: 2, 
                  strokeColor: Colors.white
                )
            ),
          )
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50,
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
                const months = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun'];
                if (value.toInt() >= 0 && value.toInt() < months.length) {
                  return Text(
                    months[value.toInt()],
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
        minY: 1150,
        maxY: 1300,
      ),
    );
  }
}