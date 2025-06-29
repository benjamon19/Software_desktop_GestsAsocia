import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/configuracion_controller.dart';
import '../../../utils/app_theme.dart';
import 'sections/tema_section.dart';
import 'sections/aplicacion_section.dart';
import 'sections/sistema_section.dart';

class ConfiguracionView extends StatelessWidget {
  const ConfiguracionView({super.key});

  @override
  Widget build(BuildContext context) {
    final ConfiguracionController controller = Get.put(ConfiguracionController());
    
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 30),
          _buildTabSelector(context, controller),
          const SizedBox(height: 30),
          Expanded(
            child: Obx(() => _buildCurrentSection(controller)),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Configuración',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.getTextPrimary(context),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Personaliza la aplicación según tus preferencias',
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.getTextSecondary(context),
          ),
        ),
      ],
    );
  }

  Widget _buildTabSelector(BuildContext context, ConfiguracionController controller) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppTheme.getInputBackground(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.getBorderLight(context),
        ),
      ),
      child: Obx(() => Row(
        children: [
          Expanded(
            child: _buildTab(
              context,
              controller,
              'tema',
              'Tema',
              Icons.palette_outlined,
            ),
          ),
          Expanded(
            child: _buildTab(
              context,
              controller,
              'aplicacion',
              'Aplicación',
              Icons.tune_outlined,
            ),
          ),
          Expanded(
            child: _buildTab(
              context,
              controller,
              'sistema',
              'Sistema',
              Icons.info_outline,
            ),
          ),
        ],
      )),
    );
  }

  Widget _buildTab(
    BuildContext context,
    ConfiguracionController controller,
    String sectionId,
    String title,
    IconData icon,
  ) {
    final isSelected = controller.selectedSection.value == sectionId;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => controller.selectSection(sectionId),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected 
                ? AppTheme.primaryColor 
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected 
                    ? Colors.white 
                    : AppTheme.getTextSecondary(context),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isSelected 
                      ? Colors.white 
                      : AppTheme.getTextPrimary(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentSection(ConfiguracionController controller) {
    switch (controller.selectedSection.value) {
      case 'tema':
        return const TemaSection();
      case 'aplicacion':
        return const AplicacionSection();
      case 'sistema':
        return const SistemaSection();
      default:
        return const TemaSection();
    }
  }
}