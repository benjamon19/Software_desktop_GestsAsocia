import 'package:flutter/material.dart';
import '../../../../../../utils/app_theme.dart';

class BackupOptionsDialog {
  static void show(BuildContext context) {
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