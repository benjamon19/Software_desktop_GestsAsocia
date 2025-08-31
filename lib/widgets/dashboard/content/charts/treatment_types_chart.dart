import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TreatmentTypesChart extends StatelessWidget {
  const TreatmentTypesChart({super.key});

  // Datos realistas de tratamientos dentales
  final List<TreatmentData> _treatmentData = const [
    TreatmentData(name: "Limpieza", value: 45, color: Color(0xFF3B82F6)),
    TreatmentData(name: "Empastes", value: 25, color: Color(0xFF10B981)),
    TreatmentData(name: "Ortodonc.", value: 15, color: Color(0xFFF59E0B)),
    TreatmentData(name: "Cirugía", value: 10, color: Color(0xFFEF4444)),
    TreatmentData(name: "Otros", value: 5, color: Color(0xFF8B5CF6)),
  ];

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: _treatmentData.asMap().entries.map((entry) {
          int index = entry.key;
          TreatmentData data = entry.value;
          
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: data.value,
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
        barTouchData: BarTouchData(enabled: false),
      ),
    );
  }
}

class TreatmentData {
  final String name;
  final double value;
  final Color color;

  const TreatmentData({
    required this.name, 
    required this.value, 
    required this.color
  });
}