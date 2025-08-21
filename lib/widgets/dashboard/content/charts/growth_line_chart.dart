import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PatientGrowthChart extends StatefulWidget {
  const PatientGrowthChart({super.key});

  @override
  State<PatientGrowthChart> createState() => _PatientGrowthChartState();
}

class _PatientGrowthChartState extends State<PatientGrowthChart> 
    with TickerProviderStateMixin {
  late AnimationController _chartController;
  late Animation<double> _chartAnimation;

  // Datos ficticios realistas para una clínica dental
  final List<FlSpot> _patientData = [
    const FlSpot(0, 1180), // Enero
    const FlSpot(1, 1205), // Febrero
    const FlSpot(2, 1234), // Marzo
    const FlSpot(3, 1260), // Abril
    const FlSpot(4, 1275), // Mayo
    const FlSpot(5, 1284), // Junio (actual)
  ];

  @override
  void initState() {
    super.initState();
    _chartController = AnimationController(
      duration: const Duration(milliseconds: 2000), 
      vsync: this
    );
    _chartAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _chartController, curve: Curves.easeOutCubic)
    );
    _chartController.forward();
  }

  @override
  void dispose() {
    _chartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _chartAnimation,
      builder: (context, child) {
        return LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: _patientData.map((spot) => FlSpot(
                  spot.x, 
                  spot.y * _chartAnimation.value
                )).toList(),
                isCurved: true,
                color: const Color(0xFF4299E1),
                barWidth: 4,
                belowBarData: BarAreaData(
                  show: true, 
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF4299E1).withValues(alpha: 0.3 * _chartAnimation.value),
                      const Color(0xFF4299E1).withValues(alpha: 0.1 * _chartAnimation.value),
                    ],
                  ),
                ),
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) => 
                    FlDotCirclePainter(
                      radius: 5 * _chartAnimation.value, 
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
          duration: const Duration(milliseconds: 300),
        );
      },
    );
  }
}