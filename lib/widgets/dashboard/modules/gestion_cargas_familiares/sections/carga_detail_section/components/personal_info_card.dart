import 'package:flutter/material.dart';
import '../../../../../../../utils/app_theme.dart';
import '../../../shared/widgets/section_title.dart';

class PersonalInfoCard extends StatelessWidget {
  final Map<String, dynamic> carga;

  const PersonalInfoCard({super.key, required this.carga});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Información Personal'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildInfoItem(context, 'Fecha de Nacimiento', carga['fechaNacimiento'], Icons.cake_outlined)),
              const SizedBox(width: 16),
              Expanded(child: _buildInfoItem(context, 'Estado', carga['estado'], Icons.toggle_on_outlined)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildInfoItem(context, 'Plan', carga['plan'], Icons.card_membership_outlined)),
              const SizedBox(width: 16),
              Expanded(child: _buildInfoItem(context, 'Fecha Ingreso', carga['fechaIngreso'], Icons.event_outlined)),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoItem(context, 'Dirección', carga['direccion'], Icons.location_on_outlined),
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
              Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppTheme.getTextSecondary(context))),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.getTextPrimary(context))),
        ],
      ),
    );
  }
}