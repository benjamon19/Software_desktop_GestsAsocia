import 'package:flutter/material.dart';
import '../../../../../../../utils/app_theme.dart';
import '../../../shared/widgets/section_title.dart';

class FamilyInfoCard extends StatelessWidget {
  final Map<String, dynamic> carga;

  const FamilyInfoCard({super.key, required this.carga});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Información Familiar'),
          const SizedBox(height: 16),
          _buildInfoItem(context, 'Asociado Titular', carga['titular'], Icons.person_outlined),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildInfoItem(context, 'Teléfono', carga['telefono'], Icons.phone_outlined)),
              const SizedBox(width: 16),
              Expanded(child: _buildInfoItem(context, 'Email', carga['email'], Icons.email_outlined)),
            ],
          ),
          const SizedBox(height: 16),
          const SectionTitle(title: 'Contacto de Emergencia'),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.getInputBackground(context),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.getBorderLight(context)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${carga['contactoEmergencia']['nombre']} (${carga['contactoEmergencia']['relacion']})',
                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.getTextPrimary(context))),
                const SizedBox(height: 4),
                Text(carga['contactoEmergencia']['telefono'],
                     style: TextStyle(fontSize: 13, color: AppTheme.getTextSecondary(context))),
              ],
            ),
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