// lib/widgets/dashboard/perfil/perfil_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../../../utils/app_theme.dart';
import 'sections/perfil_info_section.dart';
import 'sections/perfil_edit_section.dart';

class PerfilView extends StatefulWidget {
  const PerfilView({super.key});

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  final AuthController authController = Get.find<AuthController>();
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 30),
          _buildTabBar(context),
          const SizedBox(height: 20),
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        // Avatar grande
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            shape: BoxShape.circle,
          ),
          child: Obx(() => Center(
            child: Text(
              authController.userDisplayName.isNotEmpty
                  ? authController.userDisplayName[0].toUpperCase()
                  : 'A',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          )),
        ),
        
        const SizedBox(width: 24),
        
        // Información básica
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mi Perfil',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.getTextPrimary(context),
                ),
              ),
              const SizedBox(height: 8),
              Obx(() => Text(
                authController.userDisplayName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryColor,
                ),
              )),
              const SizedBox(height: 4),
              Obx(() => Text(
                authController.userEmail,
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.getTextSecondary(context),
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar(BuildContext context) {
    final tabs = [
      {'icon': Icons.person_outline, 'title': 'Información'},
      {'icon': Icons.edit_outlined, 'title': 'Editar Perfil'},
    ];

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppTheme.getInputBackground(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.getBorderLight(context),
        ),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final tab = tabs[index];
          final isSelected = selectedTabIndex == index;
          
          return Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => setState(() => selectedTabIndex = index),
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
                        tab['icon'] as IconData,
                        size: 20,
                        color: isSelected 
                            ? Colors.white 
                            : AppTheme.getTextSecondary(context),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        tab['title'] as String,
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
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTabIndex) {
      case 0:
        return const PerfilInfoSection();
      case 1:
        return const PerfilEditSection();
      default:
        return const PerfilInfoSection();
    }
  }
}