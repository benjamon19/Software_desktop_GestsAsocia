import 'package:flutter/material.dart';
import '../../../../../../../utils/app_theme.dart';
import '../../../shared/widgets/section_title.dart';

class PersonalInfoCard extends StatelessWidget {
  final Map<String, dynamic> asociado;

  const PersonalInfoCard({
    super.key,
    required this.asociado,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Información Personal'),
          const SizedBox(height: 16),
          
          _buildInfoGrid(context),
        ],
      ),
    );
  }

  Widget _buildInfoGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildInfoItem(
                context,
                'Email',
                asociado['email'],
                Icons.email_outlined,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInfoItem(
                context,
                'Teléfono',
                asociado['telefono'],
                Icons.phone_outlined,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        Row(
          children: [
            Expanded(
              child: _buildInfoItem(
                context,
                'Fecha de Nacimiento',
                asociado['fechaNacimiento'],
                Icons.cake_outlined,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInfoItem(
                context,
                'Estado Civil',
                asociado['estadoCivil'],
                Icons.people_outline,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        _buildInfoItem(
          context,
          'Dirección',
          asociado['direccion'],
          Icons.location_on_outlined,
        ),
        
        const SizedBox(height: 16),
        
        Row(
          children: [
            Expanded(
              child: _buildInfoItem(
                context,
                'Plan',
                _getPlanDisplay(asociado['plan']),
                Icons.card_membership_outlined,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInfoItem(
                context,
                'Fecha de Ingreso',
                asociado['fechaIngreso'],
                Icons.calendar_today_outlined,
              ),
            ),
          ],
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
        border: Border.all(
          color: AppTheme.getBorderLight(context),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: AppTheme.getTextSecondary(context),
              ),
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

  String _getPlanDisplay(String plan) {
    switch (plan.toLowerCase()) {
      case 'premium':
      case 'vip':
        return 'VIP';
      case 'basic':
      case 'basico':
      case 'normal':
        return 'Normal';
      default:
        return plan;
    }
  }
}