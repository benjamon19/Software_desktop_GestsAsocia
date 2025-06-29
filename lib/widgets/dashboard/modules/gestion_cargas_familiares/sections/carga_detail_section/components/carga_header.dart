import 'package:flutter/material.dart';
import '../../../../../../../utils/app_theme.dart';

class CargaHeader extends StatelessWidget {
  final Map<String, dynamic> carga;
  final VoidCallback onEdit;

  const CargaHeader({super.key, required this.carga, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primaryColor, AppTheme.primaryColor.withValues(alpha: 0.8)],
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
            child: Icon(_getParentescoIcon(), size: 40, color: Colors.white.withValues(alpha: 0.9)),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${carga['nombre']} ${carga['apellido']}', 
                     style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                Text('RUT: ${carga['rut']}', 
                     style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.9))),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('${carga['parentesco']} • ${carga['edad']} años', 
                             style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ],
            ),
          ),
          IconButton(onPressed: onEdit, icon: const Icon(Icons.edit, color: Colors.white)),
        ],
      ),
    );
  }

  IconData _getParentescoIcon() {
    switch (carga['parentesco'].toLowerCase()) {
      case 'hijo': case 'hija': return Icons.child_care;
      case 'cónyuge': return Icons.favorite;
      case 'padre': case 'madre': return Icons.elderly;
      default: return Icons.person;
    }
  }
}