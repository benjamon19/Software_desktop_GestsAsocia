import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PatientGrowthChart extends StatelessWidget {
  const PatientGrowthChart({super.key});

  // Datos más realistas y detallados para una clínica dental
  final List<FlSpot> _patientData = const [
    FlSpot(0, 1142), // Enero
    FlSpot(1, 1168), // Febrero  
    FlSpot(2, 1205), // Marzo
    FlSpot(3, 1234), // Abril
    FlSpot(4, 1267), // Mayo
    FlSpot(5, 1284), // Junio (actual)
  ];

  final List<FlSpot> _targetData = const [
    FlSpot(0, 1150), // Meta Enero
    FlSpot(1, 1180), // Meta Febrero
    FlSpot(2, 1210), // Meta Marzo
    FlSpot(3, 1240), // Meta Abril
    FlSpot(4, 1270), // Meta Mayo
    FlSpot(5, 1300), // Meta Junio
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive breakpoints
        final isLarge = constraints.maxWidth > 400;
        final isMedium = constraints.maxWidth > 280;
        final isSmall = constraints.maxHeight < 200;
        
        return Column(
          children: [
            // Header con métricas - solo si hay espacio
            if (!isSmall)
              Padding(
                padding: EdgeInsets.only(bottom: isLarge ? 12 : 8),
                child: _buildMetricsHeader(isLarge, isMedium),
              ),
            
            // Gráfico principal
            Expanded(
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    // Línea de pacientes reales
                    LineChartBarData(
                      spots: _patientData,
                      isCurved: true,
                      color: const Color(0xFF4299E1),
                      barWidth: isMedium ? 4 : 3,
                      belowBarData: BarAreaData(
                        show: true, 
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(102, 66, 153, 225), // 0xFF4299E1 with 0.4 alpha
                            Color.fromARGB(26, 66, 153, 225), // 0xFF4299E1 with 0.1 alpha
                            Colors.transparent,
                          ],
                        ),
                      ),
                      dotData: FlDotData(
                        show: isMedium,
                        getDotPainter: (spot, percent, barData, index) => 
                          FlDotCirclePainter(
                            radius: isMedium ? 6 : 4, 
                            color: const Color(0xFF4299E1), 
                            strokeWidth: 3, 
                            strokeColor: Colors.white
                          )
                      ),
                    ),
                    // Línea de meta (punteada) - solo si hay espacio
                    if (isMedium)
                      LineChartBarData(
                        spots: _targetData,
                        isCurved: true,
                        color: const Color(0xFF10B981),
                        barWidth: 2,
                        dashArray: [5, 5],
                        dotData: const FlDotData(
                          show: false,
                        ),
                      ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: isMedium,
                        reservedSize: isLarge ? 60 : 45,
                        interval: 50,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${(value / 1000).toStringAsFixed(1)}K',
                            style: TextStyle(
                              fontSize: isLarge ? 11 : 9, 
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
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
                            return Padding(
                              padding: EdgeInsets.only(top: isLarge ? 8 : 4),
                              child: Text(
                                months[value.toInt()],
                                style: TextStyle(
                                  fontSize: isLarge ? 12 : 10, 
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
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
                    show: isMedium,
                    drawHorizontalLine: true,
                    drawVerticalLine: false,
                    horizontalInterval: 50,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.grey.withValues(alpha: 0.15),
                      strokeWidth: 1,
                    ),
                  ),
                  minY: 1100,
                  maxY: 1320,
                  lineTouchData: LineTouchData(enabled: false),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMetricsHeader(bool isLarge, bool isMedium) {
    if (!isMedium) return const SizedBox.shrink();
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildMetric("Actual", "1,284", const Color(0xFF4299E1), isLarge),
        if (isLarge) _buildMetric("Meta", "1,300", const Color(0xFF10B981), isLarge),
        _buildMetric("Crecimiento", "+8.9%", const Color(0xFF6366F1), isLarge),
      ],
    );
  }

  Widget _buildMetric(String label, String value, Color color, bool isLarge) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: isLarge ? 16 : 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: isLarge ? 10 : 9,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}