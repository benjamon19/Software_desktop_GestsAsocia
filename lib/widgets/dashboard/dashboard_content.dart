import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../utils/app_theme.dart';

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> with TickerProviderStateMixin {
  late AnimationController _chartController;
  late Animation<double> _chartAnimation;

  @override
  void initState() {
    super.initState();
    _chartController = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
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
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Resumen General', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.getTextPrimary(context))),
          const SizedBox(height: 8),
          Text('Bienvenido de vuelta, aquí está tu resumen del día', style: TextStyle(fontSize: 14, color: AppTheme.getTextSecondary(context))),
          const SizedBox(height: 30),
          
          // Stats Cards sin animación
          Row(
            children: [
              Expanded(child: _buildStatCard(context, 'Total Asociados', '1280', Icons.people_outline, const Color(0xFF4299E1), const Color(0xFFEBF8FF))),
              const SizedBox(width: 20),
              Expanded(child: _buildStatCard(context, 'Citas Hoy', '34', Icons.calendar_today_outlined, const Color(0xFF48BB78), const Color(0xFFF0FDF4))),
              const SizedBox(width: 20),
              Expanded(child: _buildStatCard(context, 'Nuevos Registros', '12', Icons.person_add_outlined, const Color(0xFF9F7AEA), const Color(0xFFF9F5FF))),
              const SizedBox(width: 20),
              Expanded(child: _buildStatCard(context, 'Alertas', '3', Icons.warning_amber_outlined, const Color(0xFFF56565), const Color(0xFFFFF5F5))),
            ],
          ),
          const SizedBox(height: 30),

          // KPI Section
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: AppTheme.getSurfaceColor(context),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.black.withValues(alpha: 0.3) : Colors.grey.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Resumen', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppTheme.getTextPrimary(context))),
                  const SizedBox(height: 20),
                  // Grid centrado
                  Expanded(
                    child: Center( // Centra todo el grid
                      child: _buildResponsiveChartGrid(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---- RESPONSIVIDAD: Grid de Gráficos ---- //
  Widget _buildResponsiveChartGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // RESPONSIVIDAD: Configuración según ancho disponible
        int crossAxisCount = 2;
        double childAspectRatio = 1.8; // Más horizontal por defecto
        
        if (constraints.maxWidth > 1400) {        // RESPONSIVIDAD: Pantallas XL
          crossAxisCount = 4;
          childAspectRatio = 1.2; // Más horizontal
        } else if (constraints.maxWidth > 1000) { // RESPONSIVIDAD: Desktop
          crossAxisCount = 3;
          childAspectRatio = 1.5; // Más horizontal
        } else if (constraints.maxWidth < 600) {  // RESPONSIVIDAD: Mobile
          crossAxisCount = 1;
          childAspectRatio = 2.5; // Aún más horizontal en mobile
        }

        return GridView.count(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: childAspectRatio,
          physics: const NeverScrollableScrollPhysics(), // Evita scroll innecesario
          shrinkWrap: true, // Se ajusta al contenido
          children: [
            _buildChartCard("Crecimiento de Asociados", _lineChart()),
            _buildChartCard("Distribución por Edad", _pieChart()),
            _buildChartCard("Ingresos Mensuales", _barChart()),
            _buildChartCard("Asistencias Diarias", _animatedLineChart()),
          ],
        );
      },
    );
  }

  Widget _buildChartCard(String title, Widget chart) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 6),
            Expanded(
              child: Center( // Centra el gráfico dentro de su card
                child: Padding(padding: const EdgeInsets.all(4.0), child: chart)
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color iconColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.getSurfaceColor(context),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.black.withValues(alpha: 0.3) : Colors.grey.withValues(alpha: 0.08),
          blurRadius: 10,
          offset: const Offset(0, 4),
        )],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark ? iconColor.withValues(alpha: 0.2) : bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 16),
          Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.getTextPrimary(context))),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(fontSize: 14, color: AppTheme.getTextSecondary(context))),
        ],
      ),
    );
  }

  // ---- Gráficos Animados ---- //
  Widget _lineChart() {
    return AnimatedBuilder(
      animation: _chartAnimation,
      builder: (context, child) {
        return LineChart(
          LineChartData(
            lineBarsData: [LineChartBarData(
              spots: [FlSpot(0, 3 * _chartAnimation.value), FlSpot(1, 4 * _chartAnimation.value), FlSpot(2, 5 * _chartAnimation.value), FlSpot(3, 7 * _chartAnimation.value), FlSpot(4, 9 * _chartAnimation.value)],
              isCurved: true,
              color: Colors.blue,
              barWidth: 3,
              belowBarData: BarAreaData(show: true, color: Colors.blue.withValues(alpha: 0.3 * _chartAnimation.value)),
              dotData: FlDotData(show: true, getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(radius: 4 * _chartAnimation.value, color: Colors.blue, strokeWidth: 2, strokeColor: Colors.white)),
            )],
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: false),
          ),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  Widget _pieChart() {
    return AnimatedBuilder(
      animation: _chartAnimation,
      builder: (context, child) {
        return PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(value: 40 * _chartAnimation.value, color: Colors.blue, title: _chartAnimation.value > 0.5 ? "18-25" : "", radius: 50 * _chartAnimation.value, titleStyle: const TextStyle(fontSize: 12, color: Colors.white)),
              PieChartSectionData(value: 30 * _chartAnimation.value, color: Colors.green, title: _chartAnimation.value > 0.5 ? "26-35" : "", radius: 50 * _chartAnimation.value, titleStyle: const TextStyle(fontSize: 12, color: Colors.white)),
              PieChartSectionData(value: 20 * _chartAnimation.value, color: Colors.orange, title: _chartAnimation.value > 0.5 ? "36-50" : "", radius: 50 * _chartAnimation.value, titleStyle: const TextStyle(fontSize: 12, color: Colors.white)),
              PieChartSectionData(value: 10 * _chartAnimation.value, color: Colors.red, title: _chartAnimation.value > 0.5 ? "50+" : "", radius: 50 * _chartAnimation.value, titleStyle: const TextStyle(fontSize: 12, color: Colors.white)),
            ],
          ),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.elasticOut,
        );
      },
    );
  }

  Widget _barChart() {
    return AnimatedBuilder(
      animation: _chartAnimation,
      builder: (context, child) {
        return BarChart(
          BarChartData(
            barGroups: [
              BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 8 * _chartAnimation.value, color: Colors.blue, width: 20, borderRadius: BorderRadius.circular(4))]),
              BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 10 * _chartAnimation.value, color: Colors.green, width: 20, borderRadius: BorderRadius.circular(4))]),
              BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 6 * _chartAnimation.value, color: Colors.orange, width: 20, borderRadius: BorderRadius.circular(4))]),
            ],
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: false),
          ),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.bounceOut,
        );
      },
    );
  }

  Widget _animatedLineChart() {
    return AnimatedBuilder(
      animation: _chartAnimation,
      builder: (context, child) {
        return LineChart(
          LineChartData(
            lineBarsData: [LineChartBarData(
              spots: [FlSpot(0, 1 * _chartAnimation.value), FlSpot(1, 2 * _chartAnimation.value), FlSpot(2, 1.5 * _chartAnimation.value), FlSpot(3, 3.5 * _chartAnimation.value), FlSpot(4, 2.5 * _chartAnimation.value), FlSpot(5, 4 * _chartAnimation.value)],
              isCurved: true,
              color: Colors.purple,
              barWidth: 3,
              dotData: FlDotData(show: true, getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(radius: 3 * _chartAnimation.value, color: Colors.purple, strokeWidth: 1, strokeColor: Colors.white)),
            )],
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: false),
          ),
          duration: const Duration(milliseconds: 1200),
          curve: Curves.fastOutSlowIn,
        );
      },
    );
  }
}