import 'package:flutter/material.dart';
import 'package:gestasocia/utils/app_theme.dart';

class NewAsociadoDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.getSurfaceColor(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Row(
          children: [
            const Icon(
              Icons.person_add,
              color: Color(0xFF3B82F6),
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              'Nuevo Asociado',
              style: TextStyle(
                color: AppTheme.getTextPrimary(context),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Información Personal
                Text(
                  'Información Personal',
                  style: TextStyle(
                    color: AppTheme.getTextPrimary(context),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(child: _buildTextField(context, 'Nombre', Icons.person)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildTextField(context, 'Apellido', Icons.person_outline)),
                  ],
                ),
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(child: _buildTextField(context, 'RUT', Icons.badge)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildTextField(context, 'Fecha Nacimiento', Icons.calendar_today)),
                  ],
                ),
                const SizedBox(height: 16),
                
                _buildDropdown(context, 'Estado Civil', ['Soltero', 'Casado', 'Divorciado', 'Viudo'], Icons.favorite),
                
                const SizedBox(height: 24),
                
                // Información de Contacto
                Text(
                  'Información de Contacto',
                  style: TextStyle(
                    color: AppTheme.getTextPrimary(context),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                
                _buildTextField(context, 'Email', Icons.email),
                const SizedBox(height: 16),
                _buildTextField(context, 'Teléfono', Icons.phone),
                const SizedBox(height: 16),
                _buildTextField(context, 'Dirección', Icons.location_on),
                
                const SizedBox(height: 24),
                
                // Plan
                Text(
                  'Plan de Membresía',
                  style: TextStyle(
                    color: AppTheme.getTextPrimary(context),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                
                _buildDropdown(context, 'Plan', ['Básico', 'Premium', 'VIP', 'Empresarial'], Icons.card_membership),
              ],
            ),
          ),
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
              // Aquí no hace nada por ahora
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Crear Asociado'),
          ),
        ],
      ),
    );
  }

  static Widget _buildTextField(BuildContext context, String label, IconData icon) {
    return TextField(
      style: TextStyle(color: AppTheme.getTextPrimary(context)),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppTheme.primaryColor),
        labelStyle: TextStyle(color: AppTheme.getTextSecondary(context)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppTheme.getBorderLight(context)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppTheme.getBorderLight(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppTheme.primaryColor, width: 2),
        ),
      ),
    );
  }

  static Widget _buildDropdown(BuildContext context, String label, List<String> items, IconData icon) {
    return SizedBox(
      width: double.infinity, // ← Asegura que ocupe el ancho disponible sin desbordar
      child: DropdownButtonFormField<String>(
        initialValue: items.first,
        items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        onChanged: (value) {
          // No hace nada por ahora
        },
        style: TextStyle(color: AppTheme.getTextPrimary(context)),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppTheme.primaryColor),
          labelStyle: TextStyle(color: AppTheme.getTextSecondary(context)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppTheme.getBorderLight(context)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppTheme.getBorderLight(context)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppTheme.primaryColor, width: 2),
          ),
        ),
        dropdownColor: AppTheme.getSurfaceColor(context),
        isExpanded: true, // ← Clave: hace que el contenido se acomode bien dentro del ancho
      ),
    );
  }
}
