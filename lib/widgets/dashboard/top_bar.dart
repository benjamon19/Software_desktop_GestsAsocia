import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/dashboard_data.dart';
import '../../utils/app_theme.dart';

class TopBar extends StatelessWidget {
  final bool isDrawerOpen;
  final bool isSidebarCollapsed; // Nuevo parámetro
  final String currentPageTitle;
  final VoidCallback onMenuToggle;
  final VoidCallback onSidebarToggle; // Nuevo callback
  final AuthController authController;
  final Function(int)? onNavigateToSection;

  const TopBar({
    super.key,
    required this.isDrawerOpen,
    required this.isSidebarCollapsed,
    required this.currentPageTitle,
    required this.onMenuToggle,
    required this.onSidebarToggle,
    required this.authController,
    this.onNavigateToSection,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: AppTheme.getSurfaceColor(context),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark 
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.grey.withValues(alpha: 0.08),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Menu Button - Ahora controla el colapso del sidebar
          IconButton(
            icon: Icon(
              isSidebarCollapsed ? Icons.menu : Icons.menu_open,
              color: AppTheme.getTextPrimary(context),
            ),
            onPressed: onSidebarToggle,
            tooltip: isSidebarCollapsed ? 'Expandir menú' : 'Contraer menú',
          ),
          const SizedBox(width: 20),
          
          // Page Title
          Text(
            currentPageTitle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppTheme.getTextPrimary(context),
            ),
          ),
          const Spacer(),
          
          // Date Display
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark 
                  ? AppTheme.darkSurfaceColor.withValues(alpha: 0.8)
                  : AppTheme.backgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined, 
                  size: 16, 
                  color: AppTheme.getTextSecondary(context),
                ),
                const SizedBox(width: 8),
                Text(
                  DashboardData.getFormattedDate(),
                  style: TextStyle(
                    color: AppTheme.getTextSecondary(context),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          
          // User Menu
          _buildUserMenu(context),
        ],
      ),
    );
  }

  Widget _buildUserMenu(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 45),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.getBorderLight(context)),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppTheme.primaryColor,
              radius: 18,
              child: Text(
                authController.userDisplayName.isNotEmpty 
                    ? authController.userDisplayName[0].toUpperCase() 
                    : 'U',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  authController.userDisplayName,
                  style: TextStyle(
                    color: AppTheme.getTextPrimary(context),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  authController.userEmail,
                  style: TextStyle(
                    color: AppTheme.getTextSecondary(context),
                    fontSize: 12,
                  ),
                ),
              ],
            )),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_drop_down, 
              color: AppTheme.getTextSecondary(context),
            ),
          ],
        ),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'profile',
          child: Row(
            children: [
              Icon(
                Icons.person_outline, 
                color: AppTheme.getTextPrimary(context), 
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                'Mi Perfil',
                style: TextStyle(color: AppTheme.getTextPrimary(context)),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'settings',
          child: Row(
            children: [
              Icon(
                Icons.settings_outlined, 
                color: AppTheme.getTextPrimary(context), 
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                'Configuración',
                style: TextStyle(color: AppTheme.getTextPrimary(context)),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          enabled: false,
          height: 1,
          child: Divider(
            height: 1,
            thickness: 0.5,
            color: AppTheme.getBorderLight(context).withValues(alpha: 0.3),
          ),
        ),
        const PopupMenuItem(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.logout, color: Color(0xFFEF4444), size: 20),
              SizedBox(width: 12),
              Text('Cerrar Sesión', style: TextStyle(color: Color(0xFFEF4444))),
            ],
          ),
        ),
      ],
      onSelected: (value) => _handleMenuAction(value, context),
    );
  }

  void _handleMenuAction(String value, BuildContext context) {
    switch (value) {
      case 'profile':
        if (onNavigateToSection != null) {
          onNavigateToSection!(6);
        }
        break;
      case 'settings':
        if (onNavigateToSection != null) {
          onNavigateToSection!(5);
        }
        break;
      case 'logout':
        _showLogoutDialog(context);
        break;
    }
  }

  void _showLogoutDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppTheme.getSurfaceColor(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text(
          'Cerrar Sesión',
          style: TextStyle(color: AppTheme.getTextPrimary(context)),
        ),
        content: Text(
          '¿Estás seguro de que deseas cerrar sesión?',
          style: TextStyle(color: AppTheme.getTextSecondary(context)),
        ),
        actions: [
          TextButton(
            child: Text(
              'Cancelar', 
              style: TextStyle(color: AppTheme.getTextSecondary(context)),
            ),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: const Text(
              'Cerrar Sesión', 
              style: TextStyle(color: Color(0xFFEF4444)),
            ),
            onPressed: () {
              Get.back();
              authController.logout();
            },
          ),
        ],
      ),
    );
  }
}