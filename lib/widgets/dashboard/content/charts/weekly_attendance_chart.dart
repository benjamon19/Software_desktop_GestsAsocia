import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WeeklyAttendanceChart extends StatefulWidget {
  const WeeklyAttendanceChart({super.key});

  @override
  State<WeeklyAttendanceChart> createState() => _WeeklyAttendanceChartState();
}

class _WeeklyAttendanceChartState extends State<WeeklyAttendanceChart> 
    with TickerProviderStateMixin {
  late AnimationController _chartController;
  late Animation<double> _chartAnimation;
  bool _hasAnimated = false;

  // Datos de asistencia vs ausencias por día
  final List<AttendanceData> _attendanceData = [
    AttendanceData(day: "Lun", attended: 14, missed: 2, rate: 87.5),
    AttendanceData(day: "Mar", attended: 17, missed: 1, rate: 94.4),
    AttendanceData(day: "Mié", attended: 19, missed: 1, rate: 95.0),
    AttendanceData(day: "Jue", attended: 15, missed: 2, rate: 88.2),
    AttendanceData(day: "Vie", attended: 14, missed: 1, rate: 93.3),
    AttendanceData(day: "Sáb", attended: 8, missed: 1, rate: 88.9),
  ];

  @override
  void initState() {
    super.initState();
    if (!_hasAnimated) {
      _initializeAnimations();
      _hasAnimated = true;
    }
  }

  void _initializeAnimations() {
    _chartController = AnimationController(
      duration: const Duration(milliseconds: 1500), 
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
                        FlSpot(entry.key.toDouble(), entry.value.attended * _chartAnimation.value)
                      ).toList(),
                      isCurved: true,
                      color: const Color(0xFF10B981),
                      barWidth: 3,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFF10B981).withValues(alpha: 0.3 * _chartAnimation.value),
                            const Color(0xFF10B981).withValues(alpha: 0.05 * _chartAnimation.value),
                          ],
                        ),
                      ),
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) => 
                          FlDotCirclePainter(
                            radius: 4 * _chartAnimation.value, 
                            color: const Color(0xFF10B981), 
                            strokeWidth: 2, 
                            strokeColor: Colors.white
                          )
                      ),
                    ),
                    // Línea de ausencias
                    LineChartBarData(
                      spots: _attendanceData.asMap().entries.map((entry) => 
                        FlSpot(entry.key.toDouble(), entry.value.missed * _chartAnimation.value)
                      ).toList(),
                      isCurved: true,
                      color: const Color(0xFFEF4444),
                      barWidth: 3,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) => 
                          FlDotCirclePainter(
                            radius: 3 * _chartAnimation.value, 
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
                  lineTouchData: LineTouchData(enabled: false), // ✅ SIN TOOLTIPS
                ),
              ),
            ),
            if (_chartAnimation.value > 0.6)
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
      },
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

  AttendanceData({
    required this.day, 
    required this.attended, 
    required this.missed, 
    required this.rate
  });
}