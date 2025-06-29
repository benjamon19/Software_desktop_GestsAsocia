import 'package:flutter/material.dart';
import '../../../../../../../utils/app_theme.dart';

class HistorialCard extends StatelessWidget {
  final Map<String, dynamic> historial;
  final VoidCallback onTap;

  const HistorialCard({super.key, required this.historial, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.getInputBackground(context),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.getBorderLight(context)),
          ),
          child: Row(
            children: [
              _buildAvatarSection(),
              const SizedBox(width: 16),
              Expanded(child: _buildInfoSection(context)),
              const SizedBox(width: 16),
              _buildStatusSection(context),
              Icon(Icons.chevron_right, color: AppTheme.getTextSecondary(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: _getTipoConsultaColor().withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(color: _getTipoConsultaColor().withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(_getTipoConsultaIcon(), color: _getTipoConsultaColor(), size: 20),
          const SizedBox(height: 2),
          Text(
            historial['fecha'].split('/')[0], // Día
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: _getTipoConsultaColor(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          historial['pacienteNombre'],
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.getTextPrimary(context),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${historial['tipoConsulta']} • ${historial['odontologo']}',
          style: TextStyle(
            fontSize: 14,
            color: _getTipoConsultaColor(),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          historial['motivoPrincipal'],
          style: TextStyle(
            fontSize: 13,
            color: AppTheme.getTextSecondary(context),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.badge, size: 12, color: AppTheme.getTextSecondary(context)),
            const SizedBox(width: 4),
            Text(
              historial['pacienteRut'],
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.getTextSecondary(context),
              ),
            ),
            const SizedBox(width: 12),
            Icon(Icons.access_time, size: 12, color: AppTheme.getTextSecondary(context)),
            const SizedBox(width: 4),
            Text(
              '${historial['fecha']} ${historial['hora']}',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.getTextSecondary(context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getEstadoColor().withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _getEstadoColor().withValues(alpha: 0.3)),
          ),
          child: Text(
            historial['estado'],
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: _getEstadoColor(),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${historial['pacienteEdad']} años',
          style: TextStyle(
            fontSize: 12,
            color: AppTheme.getTextSecondary(context),
          ),
        ),
        if (historial['proximaCita'] != null) ...[
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Próx: ${historial['proximaCita']}',
              style: TextStyle(
                fontSize: 10,
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }

  IconData _getTipoConsultaIcon() {
    switch (historial['tipoConsulta'].toLowerCase()) {
      case 'consulta': return Icons.medical_information_outlined;
      case 'control': return Icons.check_circle_outline;
      case 'urgencia': return Icons.emergency;
      case 'tratamiento': return Icons.healing;
      default: return Icons.medical_services_outlined;
    }
  }

  Color _getTipoConsultaColor() {
    switch (historial['tipoConsulta'].toLowerCase()) {
      case 'consulta': return const Color(0xFF3B82F6);
      case 'control': return const Color(0xFF10B981);
      case 'urgencia': return const Color(0xFFEF4444);
      case 'tratamiento': return const Color(0xFF8B5CF6);
      default: return const Color(0xFF6B7280);
    }
  }

  Color _getEstadoColor() {
    switch (historial['estado'].toLowerCase()) {
      case 'completado': return const Color(0xFF10B981);
      case 'pendiente': return const Color(0xFFF59E0B);
      default: return const Color(0xFF6B7280);
    }
  }
}