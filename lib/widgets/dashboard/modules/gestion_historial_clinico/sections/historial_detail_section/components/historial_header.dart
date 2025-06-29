import 'package:flutter/material.dart';

class HistorialHeader extends StatelessWidget {
  final Map<String, dynamic> historial;
  final VoidCallback onEdit;

  const HistorialHeader({super.key, required this.historial, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _getTipoConsultaColor(),
            _getTipoConsultaColor().withValues(alpha: 0.8),
          ],
        ),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Row(
        children: [
          Container(
            width: 80, height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2),
            ),
            child: Icon(_getTipoConsultaIcon(), size: 40, color: Colors.white.withValues(alpha: 0.9)),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  historial['pacienteNombre'],
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  'RUT: ${historial['pacienteRut']} • ${historial['pacienteEdad']} años',
                  style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.9)),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${historial['tipoConsulta']} • ${historial['fecha']}',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getEstadoColor(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        historial['estado'],
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(onPressed: onEdit, icon: const Icon(Icons.edit, color: Colors.white)),
        ],
      ),
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