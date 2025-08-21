import 'package:flutter/material.dart';
import '../../../utils/app_theme.dart';
import 'charts/patient_growth_chart.dart';
import 'charts/age_distribution_chart.dart';
import 'charts/treatment_types_chart.dart';
import 'charts/weekly_attendance_chart.dart';
import 'cards/next_appointments_card.dart';
import 'cards/treatment_alert_card.dart';

class ChartsGridSection extends StatelessWidget {
  const ChartsGridSection({super.key});

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
          Text(
            'Análisis y Métricas', 
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.w600, 
              color: AppTheme.getTextPrimary(context)
            )
          ),
          const SizedBox(height: 20),
          
          Expanded(
            child: _buildResponsiveLayout(),
          ),
        ],
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
    return Column(
      children: [
        // Fila 1: Gráfico hero + sidebar
        Expanded(
          flex: 3,
          child: Row(
            children: [
              const Expanded(
                flex: 3,
                child: StaticChartCard(
                  title: "Crecimiento de Pacientes",
                  chart: PatientGrowthChart(),
                  isHero: true,
                ),
              ),
              const SizedBox(width: 20),
              const Expanded(
                child: StaticChartCard(
                  title: "Tipos de Tratamiento",
                  chart: TreatmentTypesChart(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        
        // Fila 2: 4 gráficos en línea
        Expanded(
          flex: 2,
          child: Row(
            children: [
              const Expanded(
                child: StaticChartCard(
                  title: "Distribución por Edades",
                  chart: AgeDistributionChart(),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: NextAppointmentsCard(),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: StaticChartCard(
                  title: "Asistencia Semanal",
                  chart: WeeklyAttendanceChart(),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: TreatmentAlertCard(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Layout para pantallas grandes (1400-1800px)
  Widget _buildLargeLayout() {
    return Column(
      children: [
        // Fila 1: Hero + Info cards
        Expanded(
          flex: 3,
          child: Row(
            children: [
              const Expanded(
                flex: 2,
                child: StaticChartCard(
                  title: "Crecimiento de Pacientes",
                  chart: PatientGrowthChart(),
                  isHero: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    const Expanded(
                      child: StaticChartCard(
                        title: "Tipos de Tratamiento",
                        chart: TreatmentTypesChart(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Expanded(
                      child: TreatmentAlertCard(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        
        // Fila 2: 3 gráficos
        Expanded(
          flex: 2,
          child: Row(
            children: [
              const Expanded(
                child: StaticChartCard(
                  title: "Distribución por Edades",
                  chart: AgeDistributionChart(),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: NextAppointmentsCard(),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: StaticChartCard(
                  title: "Asistencia Semanal",
                  chart: WeeklyAttendanceChart(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Layout para notebooks medianos (1100-1400px)
  Widget _buildMediumLayout() {
    return Column(
      children: [
        // Fila 1: Gráfico principal
        Expanded(
          flex: 2,
          child: const StaticChartCard(
            title: "Crecimiento de Pacientes",
            chart: PatientGrowthChart(),
            isHero: true,
          ),
        ),
        const SizedBox(height: 12),
        
        // Fila 2: 2 gráficos + 1 tarjeta info
        Expanded(
          flex: 2,
          child: Row(
            children: [
              const Expanded(
                child: StaticChartCard(
                  title: "Distribución por Edades",
                  chart: AgeDistributionChart(),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: StaticChartCard(
                  title: "Tipos de Tratamiento",
                  chart: TreatmentTypesChart(),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: NextAppointmentsCard(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        
        // Fila 3: 1 gráfico + 1 tarjeta
        Expanded(
          flex: 2,
          child: Row(
            children: [
              const Expanded(
                flex: 2,
                child: StaticChartCard(
                  title: "Asistencia Semanal",
                  chart: WeeklyAttendanceChart(),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: TreatmentAlertCard(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Layout compacto para notebooks pequeños (<1100px)
  Widget _buildCompactLayout() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Gráfico principal - altura fija
          SizedBox(
            height: 280,
            child: const StaticChartCard(
              title: "Crecimiento de Pacientes",
              chart: PatientGrowthChart(),
              isHero: true,
            ),
          ),
          const SizedBox(height: 12),
          
          // Fila de 3 gráficos compactos
          SizedBox(
            height: 220,
            child: Row(
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
                const SizedBox(width: 10),
                const Expanded(
                  child: StaticChartCard(
                    title: "Asistencias",
                    chart: WeeklyAttendanceChart(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          
          // Tarjetas de información - compactas
          SizedBox(
            height: 200,
            child: Row(
              children: [
                const Expanded(
                  child: CompactAppointmentsCard(),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: CompactAlertsCard(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Tarjeta de citas ultra compacta para notebooks pequeños
class CompactAppointmentsCard extends StatelessWidget {
  const CompactAppointmentsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
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
        children: [
          Text(
            'Próximas Citas',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.getTextPrimary(context),
            ),
          ),
          const SizedBox(height: 8),
          
          Expanded(
            child: ListView(
              children: [
                _buildCompactItem("09:30", "Ana García"),
                _buildCompactItem("10:15", "Carlos López"),
                _buildCompactItem("14:30", "Pedro Ruiz"),
              ],
            ),
          ),
          
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Ver todas →',
              style: TextStyle(
                fontSize: 11,
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
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              time,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(
              patient,
              style: const TextStyle(fontSize: 11),
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
      padding: const EdgeInsets.all(12),
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
        children: [
          Text(
            'Alertas Pendientes',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.getTextPrimary(context),
            ),
          ),
          const SizedBox(height: 8),
          
          Expanded(
            child: ListView(
              children: [
                _buildCompactAlert("2d", "Juan Pérez"),
                _buildCompactAlert("5d", "Elena Torres"),
                _buildCompactAlert("1d", "Miguel Santos"),
              ],
            ),
          ),
          
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Ver todas →',
              style: TextStyle(
                fontSize: 11,
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
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 25,
            child: Text(
              days,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(
              patient,
              style: const TextStyle(fontSize: 11),
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
        border: isHero ? null : null,
      ),
      child: Padding(
        padding: EdgeInsets.all(isHero ? 24 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header estático
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isHero ? 18 : 14,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.getTextPrimary(context),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: isHero ? 12 : 10,
                      color: AppTheme.getTextSecondary(context),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
            
            SizedBox(height: isHero ? 20 : 12),
            
            // Chart container - AQUÍ está la animación del contenido
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: chart, // Solo el gráfico se anima internamente
              ),
            ),
          ],
        ),
      ),
    );
  }
}