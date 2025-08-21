import 'package:flutter/material.dart';
import '../../../../utils/app_theme.dart';

class TreatmentAlertCard extends StatelessWidget {
  const TreatmentAlertCard({super.key});

  // Datos ficticios de alertas
  final List<TreatmentAlert> _alerts = const [
    TreatmentAlert(
      patient: "Juan Pérez",
      message: "Revisión post-cirugía pendiente",
      daysOverdue: 2,
    ),
    TreatmentAlert(
      patient: "Elena Torres",
      message: "Ajuste de ortodoncia vencido",
      daysOverdue: 5,
    ),
    TreatmentAlert(
      patient: "Miguel Santos",
      message: "Limpieza semestral programada",
      daysOverdue: 1,
    ),
    TreatmentAlert(
      patient: "Laura Martín",
      message: "Control de implante",
      daysOverdue: 3,
    ),
  ];

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
          // Header
          Text(
            'Alertas Pendientes',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.getTextPrimary(context),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${_alerts.length} notificaciones activas',
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.getTextSecondary(context),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Lista con scroll
          Expanded(
            child: ListView.separated(
              itemCount: _alerts.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _buildAlertItem(context, _alerts[index]);
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Link
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {},
              child: Text(
                'Ver todas las alertas →',
                style: TextStyle(
                  fontSize: 12,
                  color: const Color(0xFF3B82F6),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertItem(BuildContext context, TreatmentAlert alert) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.grey.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.grey.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Días
          Container(
            width: 25,
            child: Text(
              '${alert.daysOverdue}d',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppTheme.getTextSecondary(context),
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Información
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert.patient,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.getTextPrimary(context),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  alert.message,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.getTextSecondary(context),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TreatmentAlert {
  final String patient;
  final String message;
  final int daysOverdue;

  const TreatmentAlert({
    required this.patient,
    required this.message,
    required this.daysOverdue,
  });
}