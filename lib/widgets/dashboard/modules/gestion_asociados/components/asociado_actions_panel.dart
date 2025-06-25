import 'package:flutter/material.dart';
import '../../../../../utils/app_theme.dart';

class AsociadoActionsPanel extends StatelessWidget {
  final Map<String, dynamic> asociado;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onViewHistory;
  final VoidCallback onAddCarga;
  final VoidCallback onGenerateQR;

  const AsociadoActionsPanel({
    super.key,
    required this.asociado,
    required this.onEdit,
    required this.onDelete,
    required this.onViewHistory,
    required this.onAddCarga,
    required this.onGenerateQR,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.getSurfaceColor(context),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark 
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.settings,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Acciones',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          
          // Contenido scrolleable
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Sección: Gestión de Datos
                    _buildSectionTitle(context, 'Gestión de Datos'),
                    const SizedBox(height: 12),
                    
                    _buildActionButton(
                      context: context,
                      icon: Icons.edit,
                      title: 'Editar Información',
                      subtitle: 'Modificar datos del asociado',
                      color: const Color(0xFF3B82F6),
                      onPressed: onEdit,
                    ),
                    
                    const SizedBox(height: 8),
                    
                    _buildActionButton(
                      context: context,
                      icon: Icons.person_add,
                      title: 'Agregar Carga Familiar',
                      subtitle: 'Añadir nueva carga familiar',
                      color: const Color(0xFF10B981),
                      onPressed: onAddCarga,
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Sección: Herramientas
                    _buildSectionTitle(context, 'Herramientas'),
                    const SizedBox(height: 12),
                    
                    _buildActionButton(
                      context: context,
                      icon: Icons.qr_code,
                      title: 'Generar Código QR',
                      subtitle: 'Crear QR para identificación',
                      color: const Color(0xFF8B5CF6),
                      onPressed: onGenerateQR,
                    ),
                    
                    const SizedBox(height: 8),
                    
                    _buildActionButton(
                      context: context,
                      icon: Icons.history,
                      title: 'Ver Historial',
                      subtitle: 'Historial de cambios y actividad',
                      color: const Color(0xFF6B7280),
                      onPressed: onViewHistory,
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Sección: Opciones Avanzadas
                    _buildSectionTitle(context, 'Opciones Avanzadas'),
                    const SizedBox(height: 12),
                    
                    _buildActionButton(
                      context: context,
                      icon: Icons.download,
                      title: 'Exportar Datos',
                      subtitle: 'Descargar información en PDF',
                      color: const Color(0xFF059669),
                      onPressed: () => _showExportOptions(context),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    _buildActionButton(
                      context: context,
                      icon: Icons.backup,
                      title: 'Backup de Datos',
                      subtitle: 'Crear copia de seguridad',
                      color: const Color(0xFF0EA5E9),
                      onPressed: () => _showBackupOptions(context),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Botón de eliminar (separado y con confirmación)
                    _buildDangerSection(context),
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 16,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.getTextPrimary(context),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppTheme.getBorderLight(context),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 20,
                  ),
                ),
                
                const SizedBox(width: 16),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.getTextPrimary(context),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.getTextSecondary(context),
                        ),
                      ),
                    ],
                  ),
                ),
                
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppTheme.getTextSecondary(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDangerSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Zona de Peligro'),
        const SizedBox(height: 12),
        
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFEF4444).withOpacity(0.05),
            border: Border.all(
              color: const Color(0xFFEF4444).withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.warning_amber,
                    color: const Color(0xFFEF4444),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Eliminar Asociado',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFEF4444),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Esta acción no se puede deshacer. Se eliminarán todos los datos del asociado y sus cargas familiares.',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.getTextSecondary(context),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _showDeleteConfirmation(context),
                  icon: const Icon(
                    Icons.delete_outline,
                    size: 18,
                    color: Color(0xFFEF4444),
                  ),
                  label: const Text(
                    'Eliminar Asociado',
                    style: TextStyle(
                      color: Color(0xFFEF4444),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFEF4444)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.getSurfaceColor(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        icon: const Icon(
          Icons.warning_amber,
          color: Color(0xFFEF4444),
          size: 48,
        ),
        title: Text(
          'Confirmar Eliminación',
          style: TextStyle(
            color: AppTheme.getTextPrimary(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '¿Estás seguro de que deseas eliminar al asociado?',
              style: TextStyle(
                color: AppTheme.getTextPrimary(context),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '${asociado['nombre']} ${asociado['apellido']}',
              style: TextStyle(
                color: AppTheme.getTextPrimary(context),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Esta acción no se puede deshacer.',
              style: TextStyle(
                color: const Color(0xFFEF4444),
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancelar',
              style: TextStyle(
                color: AppTheme.getTextSecondary(context),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onDelete();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void _showExportOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.getSurfaceColor(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Opciones de Exportación',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.getTextPrimary(context),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
              title: const Text('Exportar a PDF'),
              subtitle: const Text('Informe completo en formato PDF'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.table_chart, color: Colors.green),
              title: const Text('Exportar a Excel'),
              subtitle: const Text('Datos en formato de hoja de cálculo'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showBackupOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.getSurfaceColor(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Opciones de Backup',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.getTextPrimary(context),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.cloud_upload, color: Colors.blue),
              title: const Text('Backup en la Nube'),
              subtitle: const Text('Guardar copia en servidor seguro'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.download, color: Colors.purple),
              title: const Text('Backup Local'),
              subtitle: const Text('Descargar archivo de respaldo'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}