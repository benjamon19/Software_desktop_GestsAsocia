import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AgeDistributionChart extends StatelessWidget {
  const AgeDistributionChart({super.key});

  // Datos realistas para clínica dental
  final List<PieData> _ageData = const [
    PieData(value: 15, label: "0-17", color: Color(0xFF60A5FA)), // Niños
    PieData(value: 35, label: "18-35", color: Color(0xFF34D399)), // Adultos jóvenes
    PieData(value: 32, label: "36-55", color: Color(0xFFFBBF24)), // Adultos
    PieData(value: 18, label: "56+", color: Color(0xFFF87171)), // Adultos mayores
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // AJUSTAR ESTE PADDING PARA MOVER EL GRÁFICO HACIA ABAJO
        const SizedBox(height: 80), // Cambia este valor para bajar más o menos el gráfico
        Expanded(
          flex: 3,
          child: PieChart(
            PieChartData(
              sections: _buildPieChartSections(),
              pieTouchData: PieTouchData(enabled: false),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 8,
              runSpacing: 4,
              children: _ageData.map((data) => 
                _buildLegendItem(data.label, data.color)
              ).toList(),
            ),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> _buildPieChartSections() {
    return _ageData.map((data) {
      return PieChartSectionData(
        value: data.value,
        color: data.color,
        title: "${data.value}%",
        radius: 60,
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

  const PieData({
    required this.value, 
    required this.label, 
    required this.color
  });
}