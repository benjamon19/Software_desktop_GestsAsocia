import 'package:flutter/material.dart';
import '../../../utils/app_theme.dart';
import 'charts/patient_growth_chart.dart';
import 'charts/age_distribution_chart.dart';
import 'charts/treatment_types_chart.dart';
import 'charts/weekly_attendance_chart.dart';
import 'cards/next_appointments_card.dart';
import 'cards/treatment_alert_card.dart';

class ChartsGridSection extends StatefulWidget {
  const ChartsGridSection({super.key});

  @override
  State<ChartsGridSection> createState() => _ChartsGridSectionState();
}

class _ChartsGridSectionState extends State<ChartsGridSection> {
  int _currentPage = 0;

  void _changePage(int newPage) {
    if (newPage != _currentPage && newPage >= 0 && newPage <= 3) {
      setState(() {
        _currentPage = newPage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.getSurfaceColor(context),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark 
                ? Colors.black.withValues(alpha: 0.2) 
                : Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header con navegación
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Análisis y Métricas', 
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.w600, 
                  color: AppTheme.getTextPrimary(context)
                )
              ),
              _buildPageNavigation(),
            ],
          ),
          const SizedBox(height: 20),
          
          // ANIMACIÓN SUAVE PARA CAMBIOS DE PÁGINA
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 195), // AJUSTA LA DURACIÓN AQUÍ (más alto = más lento)
              switchInCurve: Curves.easeInOut, // CAMBIA LA CURVA AQUÍ (easeIn, easeOut, elasticOut, etc.)
              switchOutCurve: Curves.easeInOut,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.1, 0), // AJUSTA EL DESPLAZAMIENTO AQUÍ (más alto = más movimiento)
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: _buildCurrentPage(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageNavigation() {
    return Row(
      children: [
        // Indicadores
        ...List.generate(4, (index) => Container(
          margin: const EdgeInsets.only(right: 6),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index 
                ? const Color(0xFF3B82F6)
                : AppTheme.getTextSecondary(context).withValues(alpha: 0.3),
          ),
        )),
        const SizedBox(width: 12),
        
        // Navegación
        _buildNavButton(Icons.chevron_left, _currentPage > 0 ? () => _changePage(_currentPage - 1) : null),
        const SizedBox(width: 6),
        _buildNavButton(Icons.chevron_right, _currentPage < 3 ? () => _changePage(_currentPage + 1) : null),
      ],
    );
  }

  Widget _buildNavButton(IconData icon, VoidCallback? onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: onPressed != null 
              ? const Color(0xFF3B82F6).withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: onPressed != null 
                ? const Color(0xFF3B82F6).withValues(alpha: 0.3)
                : AppTheme.getTextSecondary(context).withValues(alpha: 0.2),
          ),
        ),
        child: Icon(
          icon,
          size: 16,
          color: onPressed != null 
              ? const Color(0xFF3B82F6)
              : AppTheme.getTextSecondary(context).withValues(alpha: 0.4),
        ),
      ),
    );
  }

  Widget _buildCurrentPage() {
    return LayoutBuilder(
      key: ValueKey(_currentPage), // IMPORTANTE: Esto le dice al AnimatedSwitcher que es una página nueva
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        
        // Solo móvil va en columna, todo lo demás lado a lado
        bool isMobile = width < 600;
        
        switch (_currentPage) {
          case 0:
            return _buildTwoCharts(
              "Distribución por Edades", AgeDistributionChart(),
              "Tipos de Tratamiento", TreatmentTypesChart(),
              isMobile, width
            );
          case 1:
            return _buildTwoCards(
              NextAppointmentsCard(), TreatmentAlertCard(),
              isMobile, width
            );
          case 2:
            return _buildSingleChart("Asistencia Semanal", WeeklyAttendanceChart(), width);
          case 3:
          default:
            return _buildSingleChart("Crecimiento de Pacientes", PatientGrowthChart(), width);
        }
      },
    );
  }

  Widget _buildTwoCharts(String title1, Widget chart1, String title2, Widget chart2, bool isMobile, double width) {
    return Flex(
      direction: isMobile ? Axis.vertical : Axis.horizontal,
      children: [
        Expanded(child: ChartCard(title: title1, chart: chart1, width: width)),
        SizedBox(width: isMobile ? 0 : 16, height: isMobile ? 16 : 0),
        Expanded(child: ChartCard(title: title2, chart: chart2, width: width)),
      ],
    );
  }

  Widget _buildTwoCards(Widget card1, Widget card2, bool isMobile, double width) {
    return Flex(
      direction: isMobile ? Axis.vertical : Axis.horizontal,
      children: [
        Expanded(child: card1),
        SizedBox(width: isMobile ? 0 : 16, height: isMobile ? 16 : 0),
        Expanded(child: card2),
      ],
    );
  }

  Widget _buildSingleChart(String title, Widget chart, double width) {
    return ChartCard(title: title, chart: chart, width: width, isHero: true);
  }
}

class ChartCard extends StatelessWidget {
  final String title;
  final Widget chart;
  final double width;
  final bool isHero;

  const ChartCard({
    super.key,
    required this.title,
    required this.chart,
    required this.width,
    this.isHero = false,
  });

  @override
  Widget build(BuildContext context) {
    // Responsive padding y tamaños
    double padding = _getPadding();
    double titleSize = _getTitleSize();
    double borderRadius = _getBorderRadius();

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: AppTheme.getSurfaceColor(context),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: AppTheme.getTextSecondary(context).withValues(alpha: 0.1),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.w600,
              color: AppTheme.getTextPrimary(context),
            ),
          ),
          SizedBox(height: padding * 0.6),
          Expanded(child: chart),
        ],
      ),
    );
  }

  double _getPadding() {
    if (width < 600) return 12;      // Móvil
    if (width < 900) return 14;      // Tablet pequeño
    if (width < 1200) return 16;     // Tablet/laptop pequeño
    if (width < 1600) return 18;     // Laptop estándar
    return 20;                       // Desktop grande
  }

  double _getTitleSize() {
    if (width < 600) return 13;      // Móvil
    if (width < 900) return 14;      // Tablet pequeño  
    if (width < 1200) return 15;     // Tablet/laptop pequeño
    if (width < 1600) return 16;     // Laptop estándar
    return isHero ? 18 : 16;         // Desktop grande
  }

  double _getBorderRadius() {
    if (width < 600) return 8;       // Móvil
    if (width < 1200) return 10;     // Hasta laptop pequeño
    return 12;                       // Desktop
  }
}