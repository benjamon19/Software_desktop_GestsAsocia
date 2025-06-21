import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/theme_controller.dart'; // Agregar import
import '../widgets/dashboard/sidebar_menu.dart';
import '../widgets/dashboard/top_bar.dart';
import '../widgets/dashboard/dashboard_content.dart';
import '../widgets/dashboard/page_content.dart';
import '../utils/dashboard_data.dart';
import '../utils/app_theme.dart'; // Agregar import

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final AuthController authController = Get.find<AuthController>();
  final ThemeController themeController = Get.find<ThemeController>(); // Agregar esto
  bool isDrawerOpen = true;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getBackgroundColor(context), // Usar tema dinámico
      body: Row(
        children: [
          // Sidebar Menu
          if (isDrawerOpen)
            SidebarMenu(
              selectedIndex: selectedIndex,
              onItemSelected: (index) => setState(() => selectedIndex = index),
            ),
                     
          // Main Content
          Expanded(
            child: Column(
              children: [
                // Top Bar
                TopBar(
                  isDrawerOpen: isDrawerOpen,
                  currentPageTitle: DashboardData.menuItems[selectedIndex]['title'],
                  onMenuToggle: () => setState(() => isDrawerOpen = !isDrawerOpen),
                  authController: authController,
                ),
                                 
                // Page Content
                Expanded(
                  child: _buildPageContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent() {
    switch (selectedIndex) {
      case 0:
        return const DashboardContent();
      case 1:
        return PageContent(
          title: 'Gestión de Asociados',
          icon: Icons.people_outline,
          onBackToDashboard: () => setState(() => selectedIndex = 0),
        );
      case 2:
        return PageContent(
          title: 'Cargas Familiares',
          icon: Icons.family_restroom_outlined,
          onBackToDashboard: () => setState(() => selectedIndex = 0),
        );
      case 3:
        return PageContent(
          title: 'Historial Clínico',
          icon: Icons.medical_information_outlined,
          onBackToDashboard: () => setState(() => selectedIndex = 0),
        );
      case 4:
        return PageContent(
          title: 'Reserva de Horas',
          icon: Icons.schedule_outlined,
          onBackToDashboard: () => setState(() => selectedIndex = 0),
        );
      case 5:
        return PageContent(
          title: 'Configuración',
          icon: Icons.settings_outlined,
          onBackToDashboard: () => setState(() => selectedIndex = 0),
        );
      default:
        return const DashboardContent();
    }
  }
}