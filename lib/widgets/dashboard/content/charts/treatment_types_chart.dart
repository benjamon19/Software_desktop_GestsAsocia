import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TreatmentTypesChart extends StatefulWidget {
  const TreatmentTypesChart({super.key});

  @override
  State<TreatmentTypesChart> createState() => _TreatmentTypesChartState();
}

class _TreatmentTypesChartState extends State<TreatmentTypesChart> 
    with TickerProviderStateMixin {
  late AnimationController _chartController;
  late Animation<double> _chartAnimation;
  bool _hasAnimated = false;

  // Datos realistas de tratamientos dentales
  final List<TreatmentData> _treatmentData = [
    TreatmentData(name: "Limpieza", value: 45, color: const Color(0xFF3B82F6)),
    TreatmentData(name: "Empastes", value: 25, color: const Color(0xFF10B981)),
    TreatmentData(name: "Ortodonc.", value: 15, color: const Color(0xFFF59E0B)),
    TreatmentData(name: "Cirugía", value: 10, color: const Color(0xFFEF4444)),
    TreatmentData(name: "Otros", value: 5, color: const Color(0xFF8B5CF6)),
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
      duration: const Duration(milliseconds: 1600), 
      vsync: this
    );
    _chartAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _chartController, curve: Curves.bounceOut)
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
        return BarChart(
          BarChartData(
            barGroups: _treatmentData.asMap().entries.map((entry) {
              int index = entry.key;
              TreatmentData data = entry.value;
              
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: data.value * _chartAnimation.value,
                    color: data.color,
                    width: 28,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: 50,
                      color: data.color.withValues(alpha: 0.1),
                    ),
                  )
                ],
              );
            }).toList(),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 35,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      '${value.toInt()}%',
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
                    if (index >= 0 && index < _treatmentData.length) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          _treatmentData[index].name,
                          style: const TextStyle(
                            fontSize: 9, 
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
              show: true,
              drawHorizontalLine: true,
              drawVerticalLine: false,
              getDrawingHorizontalLine: (value) => FlLine(
                color: Colors.grey.withValues(alpha: 0.2),
                strokeWidth: 1,
              ),
            ),
            maxY: 50,
            barTouchData: BarTouchData(enabled: false), // ✅ SIN TOOLTIPS
          ),
        );
      },
    );
  }
}

class TreatmentData {
  final String name;
  final double value;
  final Color color;

  TreatmentData({
    required this.name, 
    required this.value, 
    required this.color
  });
}