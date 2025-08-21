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
  late Animation<double> _dotsAnimation;
  bool _hasAnimated = false;

  // Datos más realistas y detallados para una clínica dental
  final List<FlSpot> _patientData = [
    const FlSpot(0, 1142), // Enero
    const FlSpot(1, 1168), // Febrero  
    const FlSpot(2, 1205), // Marzo
    const FlSpot(3, 1234), // Abril
    const FlSpot(4, 1267), // Mayo
    const FlSpot(5, 1284), // Junio (actual)
  ];

  final List<FlSpot> _targetData = [
    const FlSpot(0, 1150), // Meta Enero
    const FlSpot(1, 1180), // Meta Febrero
    const FlSpot(2, 1210), // Meta Marzo
    const FlSpot(3, 1240), // Meta Abril
    const FlSpot(4, 1270), // Meta Mayo
    const FlSpot(5, 1300), // Meta Junio
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
      duration: const Duration(milliseconds: 2500), 
      vsync: this
    );
    
    _chartAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _chartController, 
        curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic)
      )
    );
    
    _dotsAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _chartController, 
        curve: const Interval(0.5, 1.0, curve: Curves.elasticOut)
      )
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
      animation: _chartController,
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            // Responsive breakpoints
            final isLarge = constraints.maxWidth > 400;
            final isMedium = constraints.maxWidth > 280;
            final isSmall = constraints.maxHeight < 200;
            
            return Column(
              children: [
                // Header con métricas - solo si hay espacio
                if (_chartAnimation.value > 0.3 && !isSmall)
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
                          spots: _patientData.map((spot) => FlSpot(
                            spot.x, 
                            spot.y * _chartAnimation.value
                          )).toList(),
                          isCurved: true,
                          color: const Color(0xFF4299E1),
                          barWidth: isMedium ? 4 : 3,
                          belowBarData: BarAreaData(
                            show: true, 
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color(0xFF4299E1).withValues(alpha: 0.4 * _chartAnimation.value),
                                const Color(0xFF4299E1).withValues(alpha: 0.1 * _chartAnimation.value),
                                Colors.transparent,
                              ],
                            ),
                          ),
                          dotData: FlDotData(
                            show: _dotsAnimation.value > 0.5 && isMedium,
                            getDotPainter: (spot, percent, barData, index) => 
                              FlDotCirclePainter(
                                radius: (isMedium ? 6 : 4) * _dotsAnimation.value, 
                                color: const Color(0xFF4299E1), 
                                strokeWidth: 3, 
                                strokeColor: Colors.white
                              )
                          ),
                        ),
                        // Línea de meta (punteada) - solo si hay espacio
                        if (_chartAnimation.value > 0.6 && isMedium)
                          LineChartBarData(
                            spots: _targetData.map((spot) => FlSpot(
                              spot.x, 
                              spot.y * _chartAnimation.value
                            )).toList(),
                            isCurved: true,
                            color: const Color(0xFF10B981),
                            barWidth: 2,
                            dashArray: [5, 5],
                            dotData: FlDotData(
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