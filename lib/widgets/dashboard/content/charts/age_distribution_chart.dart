import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AgeDistributionChart extends StatefulWidget {
  const AgeDistributionChart({super.key});

  @override
  State<AgeDistributionChart> createState() => _AgeDistributionChartState();
}

class _AgeDistributionChartState extends State<AgeDistributionChart> 
    with TickerProviderStateMixin {
  late AnimationController _chartController;
  late Animation<double> _chartAnimation;
  bool _hasAnimated = false;

  // Datos realistas para clínica dental
  final List<PieData> _ageData = [
    PieData(value: 15, label: "0-17", color: const Color(0xFF60A5FA)), // Niños
    PieData(value: 35, label: "18-35", color: const Color(0xFF34D399)), // Adultos jóvenes
    PieData(value: 32, label: "36-55", color: const Color(0xFFFBBF24)), // Adultos
    PieData(value: 18, label: "56+", color: const Color(0xFFF87171)), // Adultos mayores
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
      duration: const Duration(milliseconds: 1800), 
      vsync: this
    );
    _chartAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _chartController, curve: Curves.elasticOut)
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
              flex: 3,
              child: PieChart(
                PieChartData(
                  sections: _buildPieChartSections(),
                  pieTouchData: PieTouchData(enabled: false), // ✅ SIN TOOLTIPS
                ),
              ),
            ),
            if (_chartAnimation.value > 0.5)
              Expanded(
                flex: 1,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 4,
                  children: _ageData.map((data) => 
                    _buildLegendItem(data.label, data.color)
                  ).toList(),
                ),
              ),
          ],
        );
      },
    );
  }

  List<PieChartSectionData> _buildPieChartSections() {
    return _ageData.map((data) {
      return PieChartSectionData(
        value: data.value * _chartAnimation.value,
        color: data.color,
        title: _chartAnimation.value > 0.7 ? "${data.value}%" : "",
        radius: 60 * _chartAnimation.value,
        titleStyle: const TextStyle(
          fontSize: 12, 
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
      );
    }).toList();
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),
      ],
    );
  }
}

class PieData {
  final double value;
  final String label;
  final Color color;

  PieData({
    required this.value, 
    required this.label, 
    required this.color
  });
}