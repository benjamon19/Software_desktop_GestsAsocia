import 'package:flutter/material.dart';
import '../../../../../../../utils/app_theme.dart';

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
          _buildSectionTitle(context),
          const SizedBox(height: 20),
          _buildInfoGrid(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.person_outline,
            color: AppTheme.primaryColor,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Información Personal',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.getTextPrimary(context),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoGrid(BuildContext context) {
    return Column(
      children: [
        // Primera fila: Email y Teléfono
        Row(
          children: [
            Expanded(
              child: _buildInfoItem(
                context,
                'Email',
                asociado['email'] ?? 'No especificado',
                Icons.email_outlined,
                AppTheme.primaryColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInfoItem(
                context,
                'Teléfono',
                asociado['telefono'] ?? 'No especificado',
                Icons.phone_outlined,
                Colors.green,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Segunda fila: Fecha de Nacimiento y Estado Civil
        Row(
          children: [
            Expanded(
              child: _buildInfoItem(
                context,
                'Fecha de Nacimiento',
                asociado['fechaNacimiento'] ?? 'No especificado',
                Icons.cake_outlined,
                Colors.orange,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInfoItem(
                context,
                'Estado Civil',
                asociado['estadoCivil'] ?? 'No especificado',
                Icons.favorite_outline,
                Colors.purple,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Tercera fila: Dirección (ancho completo)
        _buildInfoItem(
          context,
          'Dirección',
          asociado['direccion'] ?? 'No especificado',
          Icons.location_on_outlined,
          Colors.blue,
        ),
        
        const SizedBox(height: 16),
        
        // Cuarta fila: Plan y Fecha de Ingreso
        Row(
          children: [
            Expanded(
              child: _buildInfoItem(
                context,
                'Plan de Membresía',
                _getPlanDisplay(asociado['plan']),
                Icons.card_membership_outlined,
                _getPlanColor(asociado['plan']),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInfoItem(
                context,
                'Fecha de Ingreso',
                asociado['fechaIngreso'] ?? 'No especificado',
                Icons.calendar_today_outlined,
                Colors.teal,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoItem(BuildContext context, String label, String value, IconData icon, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.getSurfaceColor(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.getBorderLight(context).withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: iconColor.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header con icono y label
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  icon,
                  size: 16,
                  color: iconColor,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.getTextSecondary(context),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Valor
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppTheme.getTextPrimary(context),
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  String _getPlanDisplay(String? plan) {
    if (plan == null) return 'No especificado';
    
    switch (plan.toLowerCase()) {
      case 'premium':
        return 'Premium';
      case 'vip':
        return 'VIP';
      case 'basic':
      case 'basico':
      case 'básico':
        return 'Básico';
      case 'empresarial':
        return 'Empresarial';
      default:
        return plan;
    }
  }

  Color _getPlanColor(String? plan) {
    if (plan == null) return Colors.grey;
    
    switch (plan.toLowerCase()) {
      case 'premium':
        return Colors.orange;
      case 'vip':
        return Colors.purple;
      case 'basic':
      case 'basico':
      case 'básico':
        return Colors.blue;
      case 'empresarial':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}