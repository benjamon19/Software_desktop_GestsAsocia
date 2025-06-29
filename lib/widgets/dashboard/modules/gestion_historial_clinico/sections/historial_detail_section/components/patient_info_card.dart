import 'package:flutter/material.dart';
import '../../../../../../../utils/app_theme.dart';
import '../../../shared/widgets/section_title.dart';

class PatientInfoCard extends StatelessWidget {
  final Map<String, dynamic> historial;

  const PatientInfoCard({super.key, required this.historial});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Información del Paciente'),
          const SizedBox(height: 16),
          
          // Datos básicos
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  context,
                  'Teléfono',
                  historial['pacienteTelefono'],
                  Icons.phone_outlined,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildInfoItem(
                  context,
                  'Asociado Titular',
                  historial['asociadoTitular'],
                  Icons.person_outlined,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Condiciones médicas
          _buildMedicalConditionsSection(context),
          
          const SizedBox(height: 16),
          
          // Antecedentes odontológicos
          _buildDentalHistorySection(context),
          
          const SizedBox(height: 16),
          
          // Hábitos
          _buildHabitsSection(context),
          
          const SizedBox(height: 16),
          
          // Contacto de emergencia
          _buildEmergencyContactSection(context),
        ],
      ),
    );
  }

  Widget _buildMedicalConditionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Información Médica General',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.getTextPrimary(context),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildListInfoItem(
                context,
                'Condiciones Médicas',
                historial['condicionesMedicas'],
                Icons.medical_information_outlined,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildListInfoItem(
                context,
                'Medicamentos Actuales',
                historial['medicamentosActuales'],
                Icons.medication_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildListInfoItem(
                context,
                'Alergias',
                historial['alergias'],
                Icons.warning_amber_outlined,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInfoItem(
                context,
                'Embarazo',
                historial['embarazo'] ? 'Sí' : 'No',
                Icons.pregnant_woman_outlined,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDentalHistorySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Antecedentes Odontológicos',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.getTextPrimary(context),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildInfoItem(
                context,
                'Última Visita',
                historial['ultimaVisita'],
                Icons.event_outlined,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInfoItem(
                context,
                'Experiencias Negativas',
                historial['experienciasNegativas'],
                Icons.sentiment_dissatisfied_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildListInfoItem(
                context,
                'Tratamientos Previos',
                historial['tratamientosPrevios'],
                Icons.healing_outlined,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildListInfoItem(
                context,
                'Problemas Frecuentes',
                historial['problemasFrecuentes'],
                Icons.report_problem_outlined,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHabitsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hábitos y Estilo de Vida',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.getTextPrimary(context),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildInfoItem(
                context,
                'Higiene Dental',
                historial['higieneDental'],
                Icons.cleaning_services_outlined,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInfoItem(
                context,
                'Alimentación',
                historial['alimentacion'],
                Icons.restaurant_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildListInfoItem(
          context,
          'Hábitos',
          historial['habitos'],
          Icons.psychology_outlined,
        ),
      ],
    );
  }

  Widget _buildEmergencyContactSection(BuildContext context) {
    final contacto = historial['contactoEmergencia'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contacto de Emergencia',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.getTextPrimary(context),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.getInputBackground(context),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.getBorderLight(context)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.emergency,
                color: const Color(0xFFEF4444),
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${contacto['nombre']} (${contacto['relacion']})',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.getTextPrimary(context),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      contacto['telefono'],
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.getTextSecondary(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
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
              'Ninguno registrado',
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