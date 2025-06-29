import 'package:flutter/material.dart';
import '../../../../../../../utils/app_theme.dart';
import '../../../shared/widgets/section_title.dart';

class ConsultationInfoCard extends StatelessWidget {
  final Map<String, dynamic> historial;

  const ConsultationInfoCard({super.key, required this.historial});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Información de la Consulta'),
          const SizedBox(height: 16),
          
          // Información básica de la consulta
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  context,
                  'Fecha y Hora',
                  '${historial['fecha']} ${historial['hora']}',
                  Icons.schedule_outlined,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildInfoItem(
                  context,
                  'Odontólogo',
                  historial['odontologo'],
                  Icons.medical_services_outlined,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Motivo y síntomas
          _buildInfoItem(
            context,
            'Motivo Principal',
            historial['motivoPrincipal'],
            Icons.help_outline,
          ),
          
          const SizedBox(height: 16),
          
          _buildListInfoItem(
            context,
            'Síntomas Reportados',
            historial['sintomasReportados'],
            Icons.sick_outlined,
          ),
          
          const SizedBox(height: 16),
          
          // Diagnóstico y observaciones
          _buildInfoItem(
            context,
            'Diagnóstico',
            historial['diagnostico'],
            Icons.medical_information_outlined,
          ),
          
          const SizedBox(height: 16),
          
          _buildInfoItem(
            context,
            'Observaciones del Odontólogo',
            historial['observacionesOdontologo'],
            Icons.notes_outlined,
          ),
          
          const SizedBox(height: 16),
          
          // Tratamiento y próxima cita
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  context,
                  'Tratamiento Recomendado',
                  historial['tratamientoRecomendado'],
                  Icons.healing_outlined,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildInfoItem(
                  context,
                  'Próxima Cita',
                  historial['proximaCita'] ?? 'No programada',
                  Icons.event_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.getInputBackground(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.getBorderLight(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: AppTheme.getTextSecondary(context)),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.getTextSecondary(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.getTextPrimary(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListInfoItem(BuildContext context, String label, List<dynamic> items, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.getInputBackground(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.getBorderLight(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: AppTheme.getTextSecondary(context)),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.getTextSecondary(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (items.isEmpty)
            Text(
              'No se reportaron síntomas específicos',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: AppTheme.getTextSecondary(context),
              ),
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.map<Widget>((item) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '• $item',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.getTextPrimary(context),
                  ),
                ),
              )).toList(),
            ),
        ],
      ),
    );
  }
}