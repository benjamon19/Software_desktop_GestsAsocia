import 'package:flutter/material.dart';
import '../../../../utils/app_theme.dart';

class NextAppointmentsCard extends StatelessWidget {
  const NextAppointmentsCard({super.key});

  // Datos ficticios de próximas citas
  final List<AppointmentData> _upcomingAppointments = const [
    AppointmentData(
      time: "09:30",
      patient: "Ana García",
      treatment: "Limpieza dental",
    ),
    AppointmentData(
      time: "10:15",
      patient: "Carlos López",
      treatment: "Empaste",
    ),
    AppointmentData(
      time: "11:00",
      patient: "María Silva",
      treatment: "Revisión",
    ),
    AppointmentData(
      time: "11:45",
      patient: "Roberto Díaz",
      treatment: "Extracción",
    ),
    AppointmentData(
      time: "14:30",
      patient: "Pedro Ruiz",
      treatment: "Ortodoncia",
    ),
    AppointmentData(
      time: "15:15",
      patient: "Laura Moreno",
      treatment: "Blanqueamiento",
    ),
    AppointmentData(
      time: "16:00",
      patient: "José Martín",
      treatment: "Implante",
    ),
    AppointmentData(
      time: "16:45",
      patient: "Carmen Vega",
      treatment: "Endodoncia",
    ),
    AppointmentData(
      time: "17:30",
      patient: "Antonio Ruiz",
      treatment: "Limpieza",
    ),
    AppointmentData(
      time: "18:15",
      patient: "Isabel Romero",
      treatment: "Consulta",
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
            'Próximas Citas',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.getTextPrimary(context),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Hoy - ${_upcomingAppointments.length} programadas',
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.getTextSecondary(context),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Lista con scroll
          Expanded(
            child: ListView.separated(
              itemCount: _upcomingAppointments.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _buildAppointmentItem(context, _upcomingAppointments[index]);
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
                'Ver todas las citas →',
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

  Widget _buildAppointmentItem(BuildContext context, AppointmentData appointment) {
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
          // Hora
          Container(
            width: 45,
            child: Text(
              appointment.time,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppTheme.getTextPrimary(context),
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
                  appointment.patient,
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
                  appointment.treatment,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.getTextSecondary(context),
                  ),
                  maxLines: 1,
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

class AppointmentData {
  final String time;
  final String patient;
  final String treatment;

  const AppointmentData({
    required this.time,
    required this.patient,
    required this.treatment,
  });
}