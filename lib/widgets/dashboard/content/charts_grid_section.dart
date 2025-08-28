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

class _ChartsGridSectionState extends State<ChartsGridSection> 
    with SingleTickerProviderStateMixin {
  int _currentPage = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutQuart));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _changePage(int newPage) {
    if (newPage != _currentPage && newPage >= 0 && newPage <= 3) {
      _animationController.reset();
      setState(() {
        _currentPage = newPage;
      });
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppTheme.getSurfaceColor(context),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark 
                ? Colors.black.withValues(alpha: 0.3) 
                : Colors.grey.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
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
          
          Expanded(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: _buildResponsiveLayout(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageNavigation() {
    return Row(
      children: [
        // Indicadores de página (4 páginas)
        Row(
          children: List.generate(4, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index 
                    ? const Color(0xFF3B82F6)
                    : AppTheme.getTextSecondary(context).withValues(alpha: 0.3),
              ),
            );
          }),
        ),
        const SizedBox(width: 16),
        
        // Botones de navegación
        Row(
          children: [
            _buildNavButton(
              icon: Icons.chevron_left,
              onPressed: _currentPage > 0 ? () => _changePage(_currentPage - 1) : null,
            ),
            const SizedBox(width: 8),
            _buildNavButton(
              icon: Icons.chevron_right,
              onPressed: _currentPage < 3 ? () => _changePage(_currentPage + 1) : null,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNavButton({required IconData icon, VoidCallback? onPressed}) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: onPressed != null 
            ? const Color(0xFF3B82F6).withValues(alpha: 0.1)
            : AppTheme.getTextSecondary(context).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: onPressed != null 
              ? const Color(0xFF3B82F6).withValues(alpha: 0.2)
              : AppTheme.getTextSecondary(context).withValues(alpha: 0.2),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onPressed,
          child: Icon(
            icon,
            size: 18,
            color: onPressed != null 
                ? const Color(0xFF3B82F6)
                : AppTheme.getTextSecondary(context).withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }

  Widget _buildResponsiveLayout() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Breakpoints mejorados para mejor experiencia
        if (constraints.maxWidth > 1800) {
          return _buildExtraLargeLayout(); // 27" y monitores ultra anchos
        } else if (constraints.maxWidth > 1400) {
          return _buildLargeLayout(); // 24" estándar
        } else if (constraints.maxWidth > 1100) {
          return _buildMediumLayout(); // Notebooks grandes 15-17"
        } else {
          return _buildCompactLayout(); // Notebooks pequeños 13-14"
        }
      },
    );
  }

  // Layout para monitores extra grandes (1800px+)
  Widget _buildExtraLargeLayout() {
    switch (_currentPage) {
      case 0:
        // Página 1: Distribución por edades + Tipos de tratamiento
        return Row(
          children: [
            const Expanded(
              child: StaticChartCard(
                title: "Distribución por Edades",
                chart: AgeDistributionChart(),
                isHero: true,
              ),
            ),
            const SizedBox(width: 20),
            const Expanded(
              child: StaticChartCard(
                title: "Tipos de Tratamiento",
                chart: TreatmentTypesChart(),
                isHero: true,
              ),
            ),
          ],
        );
      case 1:
        // Página 2: Próximas citas + Alertas pendientes
        return Row(
          children: [
            const Expanded(
              child: NextAppointmentsCard(),
            ),
            const SizedBox(width: 20),
            const Expanded(
              child: TreatmentAlertCard(),
            ),
          ],
        );
      case 2:
        // Página 3: Asistencia semanal
        return const StaticChartCard(
          title: "Asistencia Semanal",
          chart: WeeklyAttendanceChart(),
          isHero: true,
        );
      case 3:
      default:
        // Página 4: Crecimiento de pacientes
        return const StaticChartCard(
          title: "Crecimiento de Pacientes",
          chart: PatientGrowthChart(),
          isHero: true,
        );
    }
  }

  // Layout para pantallas grandes (1400-1800px)
  Widget _buildLargeLayout() {
    switch (_currentPage) {
      case 0:
        // Página 1: Distribución por edades + Tipos de tratamiento
        return Row(
          children: [
            const Expanded(
              child: StaticChartCard(
                title: "Distribución por Edades",
                chart: AgeDistributionChart(),
                isHero: true,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: StaticChartCard(
                title: "Tipos de Tratamiento",
                chart: TreatmentTypesChart(),
                isHero: true,
              ),
            ),
          ],
        );
      case 1:
        // Página 2: Próximas citas + Alertas pendientes
        return Row(
          children: [
            const Expanded(
              child: NextAppointmentsCard(),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: TreatmentAlertCard(),
            ),
          ],
        );
      case 2:
        // Página 3: Asistencia semanal
        return const StaticChartCard(
          title: "Asistencia Semanal",
          chart: WeeklyAttendanceChart(),
          isHero: true,
        );
      case 3:
      default:
        // Página 4: Crecimiento de pacientes
        return const StaticChartCard(
          title: "Crecimiento de Pacientes",
          chart: PatientGrowthChart(),
          isHero: true,
        );
    }
  }

  // Layout para notebooks medianos (1100-1400px)
  Widget _buildMediumLayout() {
    switch (_currentPage) {
      case 0:
        // Página 1: Distribución por edades + Tipos de tratamiento
        return Column(
          children: [
            const Expanded(
              child: StaticChartCard(
                title: "Distribución por Edades",
                chart: AgeDistributionChart(),
                isHero: true,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: StaticChartCard(
                title: "Tipos de Tratamiento",
                chart: TreatmentTypesChart(),
                isHero: true,
              ),
            ),
          ],
        );
      case 1:
        // Página 2: Próximas citas + Alertas pendientes
        return Row(
          children: [
            const Expanded(
              child: NextAppointmentsCard(),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: TreatmentAlertCard(),
            ),
          ],
        );
      case 2:
        // Página 3: Asistencia semanal
        return const StaticChartCard(
          title: "Asistencia Semanal",
          chart: WeeklyAttendanceChart(),
          isHero: true,
        );
      case 3:
      default:
        // Página 4: Crecimiento de pacientes
        return const StaticChartCard(
          title: "Crecimiento de Pacientes",
          chart: PatientGrowthChart(),
          isHero: true,
        );
    }
  }

  // Layout compacto para notebooks pequeños (<1100px)
  Widget _buildCompactLayout() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 240,
            child: _getCompactPageContent(),
          ),
        ],
      ),
    );
  }

  Widget _getCompactPageContent() {
    switch (_currentPage) {
      case 0:
        // Página 1: Distribución por edades + Tipos de tratamiento
        return Row(
          children: [
            const Expanded(
              child: StaticChartCard(
                title: "Edades",
                chart: AgeDistributionChart(),
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: StaticChartCard(
                title: "Tratamientos",
                chart: TreatmentTypesChart(),
              ),
            ),
          ],
        );
      case 1:
        // Página 2: Próximas citas + Alertas pendientes
        return Row(
          children: [
            const Expanded(
              child: CompactAppointmentsCard(),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: CompactAlertsCard(),
            ),
          ],
        );
      case 2:
        // Página 3: Asistencia semanal
        return const StaticChartCard(
          title: "Asistencia Semanal",
          chart: WeeklyAttendanceChart(),
          isHero: true,
        );
      case 3:
      default:
        // Página 4: Crecimiento de pacientes
        return const StaticChartCard(
          title: "Crecimiento de Pacientes",
          chart: PatientGrowthChart(),
          isHero: true,
        );
    }
  }
}

// Tarjeta de citas ultra compacta para notebooks pequeños
class CompactAppointmentsCard extends StatelessWidget {
  const CompactAppointmentsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.getSurfaceColor(context),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark 
                ? Colors.black.withValues(alpha: 0.3) 
                : Colors.grey.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Próximas Citas',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppTheme.getTextPrimary(context),
            ),
          ),
          const SizedBox(height: 6),
          
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                final items = [
                  ("09:30", "Ana García"),
                  ("10:15", "Carlos López"),
                  ("14:30", "Pedro Ruiz"),
                ];
                return _buildCompactItem(items[index].$1, items[index].$2);
              },
            ),
          ),
          
          const SizedBox(height: 6),
          Center(
            child: Text(
              'Ver todas →',
              style: TextStyle(
                fontSize: 10,
                color: const Color(0xFF3B82F6),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactItem(String time, String patient) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 35,
            child: Text(
              time,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(
              patient,
              style: const TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// Tarjeta de alertas ultra compacta
class CompactAlertsCard extends StatelessWidget {
  const CompactAlertsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.getSurfaceColor(context),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark 
                ? Colors.black.withValues(alpha: 0.3) 
                : Colors.grey.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Alertas Pendientes',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppTheme.getTextPrimary(context),
            ),
          ),
          const SizedBox(height: 6),
          
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                final items = [
                  ("2d", "Juan Pérez"),
                  ("5d", "Elena Torres"),
                  ("1d", "Miguel Santos"),
                ];
                return _buildCompactAlert(items[index].$1, items[index].$2);
              },
            ),
          ),
          
          const SizedBox(height: 6),
          Center(
            child: Text(
              'Ver todas →',
              style: TextStyle(
                fontSize: 10,
                color: const Color(0xFF3B82F6),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactAlert(String days, String patient) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            child: Text(
              days,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(
              patient,
              style: const TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// ChartCard ESTÁTICA - Solo contenedores sin animación
class StaticChartCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget chart;
  final bool isHero;

  const StaticChartCard({
    super.key,
    required this.title,
    required this.chart,
    this.subtitle,
    this.isHero = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isHero ? 16 : 12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isHero ? [
            AppTheme.getSurfaceColor(context),
            AppTheme.getSurfaceColor(context).withValues(alpha: 0.95),
            const Color(0xFF3B82F6).withValues(alpha: 0.05),
          ] : [
            AppTheme.getSurfaceColor(context),
            AppTheme.getSurfaceColor(context).withValues(alpha: 0.9),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: isHero 
                ? const Color(0xFF3B82F6).withValues(alpha: 0.15)
                : Colors.grey.withValues(alpha: 0.1),
            blurRadius: isHero ? 20 : 10,
            offset: Offset(0, isHero ? 8 : 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isHero ? 20 : 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header estático
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: isHero ? 16 : 12,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.getTextPrimary(context),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Flexible(
                    child: Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: isHero ? 11 : 9,
                        color: AppTheme.getTextSecondary(context),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            ),
            
            SizedBox(height: isHero ? 16 : 8),
            
            // Chart container
            Flexible(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: chart,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}