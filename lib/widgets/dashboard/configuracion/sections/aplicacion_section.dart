import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../controllers/configuracion_controller.dart';
import '../../../../../utils/app_theme.dart';

class AplicacionSection extends StatelessWidget {
  const AplicacionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ConfiguracionController controller = Get.find<ConfiguracionController>();
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.getSurfaceColor(context),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark 
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(context),
          const SizedBox(height: 24),
          _buildBasicSettings(context, controller),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.tune_outlined,
            color: AppTheme.primaryColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Configuración de Aplicación',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.getTextPrimary(context),
              ),
            ),
            Text(
              'Personaliza el comportamiento básico',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.getTextSecondary(context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBasicSettings(BuildContext context, ConfiguracionController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Autoguardado
        Obx(() => _buildSwitchTile(
          context,
          'Autoguardado',
          'Guarda automáticamente los cambios en formularios',
          Icons.save_outlined,
          controller.autoSave.value,
          (value) => controller.toggleAutoSave(value),
        )),
        
        const SizedBox(height: 16),
        
        // Confirmaciones
        Obx(() => _buildSwitchTile(
          context,
          'Confirmar eliminaciones',
          'Solicita confirmación antes de eliminar registros',
          Icons.delete_outline,
          controller.confirmActions.value,
          (value) => controller.toggleConfirmActions(value),
        )),
        
        const SizedBox(height: 16),
        
        // Formato de fecha
        _buildDateFormatTile(context, controller),
      ],
    );
  }

  Widget _buildSwitchTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.getInputBackground(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.getBorderLight(context),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: value 
                  ? AppTheme.primaryColor.withValues(alpha: 0.1)
                  : AppTheme.getTextSecondary(context).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: value 
                  ? AppTheme.primaryColor 
                  : AppTheme.getTextSecondary(context),
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
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.getTextPrimary(context),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.getTextSecondary(context),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppTheme.primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildDateFormatTile(BuildContext context, ConfiguracionController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.getInputBackground(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.getBorderLight(context),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.calendar_today_outlined,
                  color: AppTheme.primaryColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Formato de Fecha',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.getTextPrimary(context),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Cómo se muestran las fechas en el sistema',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.getTextSecondary(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Obx(() => DropdownButtonFormField<String>(
            initialValue: controller.dateFormat.value,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppTheme.getSurfaceColor(context),
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
                borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            style: TextStyle(
              color: AppTheme.getTextPrimary(context),
              fontSize: 14,
            ),
            dropdownColor: AppTheme.getSurfaceColor(context),
            items: const [
              DropdownMenuItem(value: 'dd/mm/yyyy', child: Text('DD/MM/AAAA (28/06/2025)')),
              DropdownMenuItem(value: 'mm/dd/yyyy', child: Text('MM/DD/AAAA (06/28/2025)')),
              DropdownMenuItem(value: 'yyyy-mm-dd', child: Text('AAAA-MM-DD (2025-06-28)')),
            ],
            onChanged: (value) {
              if (value != null) {
                controller.changeDateFormat(value);
              }
            },
          )),
        ],
      ),
    );
  }
}