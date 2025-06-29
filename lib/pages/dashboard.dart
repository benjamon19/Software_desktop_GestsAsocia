import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/theme_controller.dart';
import '../widgets/dashboard/sidebar_menu.dart';
import '../widgets/dashboard/top_bar.dart';
import '../widgets/dashboard/dashboard_content.dart';
// IMPORTACIÓN - Módulo de Asociados
import '../widgets/dashboard/modules/gestion_asociados/asociados_main_view.dart';
// IMPORTACIÓN - Módulo de Cargas Familiares
import '../widgets/dashboard/modules/gestion_cargas_familiares/cargas_familiares_main_view.dart';
import '../utils/dashboard_data.dart';
import '../utils/app_theme.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final AuthController authController = Get.find<AuthController>();
  final ThemeController themeController = Get.find<ThemeController>();
  bool isDrawerOpen = true;
  int selectedIndex = 0;

  // NUEVO: Método para obtener el título de la página actual
  String _getCurrentPageTitle() {
    switch (selectedIndex) {
      case 0:
        return DashboardData.menuItems[0]['title'];
      case 1:
        return DashboardData.menuItems[1]['title'];
      case 2:
        return DashboardData.menuItems[2]['title'];
      case 3:
        return DashboardData.menuItems[3]['title'];
      case 4:
        return DashboardData.menuItems[4]['title'];
      case 5:
        return 'Configuración'; // Título personalizado para configuración
      case 6: // NUEVO: Caso para perfil
        return 'Mi Perfil'; // Título personalizado para perfil
      default:
        return DashboardData.menuItems[0]['title'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getBackgroundColor(context),
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
                // Top Bar - CAMBIO: usar el método personalizado
                TopBar(
                  isDrawerOpen: isDrawerOpen,
                  currentPageTitle: _getCurrentPageTitle(), // CAMBIO AQUÍ
                  onMenuToggle: () => setState(() => isDrawerOpen = !isDrawerOpen),
                  authController: authController,
                  onNavigateToSection: (index) {
                    debugPrint('Dashboard recibió navegación a index: $index');
                    setState(() => selectedIndex = index);
                  },
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
        return const DashboardContent(); // Vista home
      case 1:
        return const AsociadosMainView(); // Vista de Asociados
      case 2:
        return const CargasFamiliaresMainView(); // Vista de Cargas Familiares
      case 3:
        return const HistorialClinicoMainView(); // Vista de Historial Clínico
      case 4:
        return _buildPlaceholderView(
          title: 'Reserva de Horas',
          icon: Icons.schedule_outlined,
          description: 'Sistema de reservas médicas\n(Próximamente)',
        );
      case 5: // Mantener case 5 para que TopBar pueda navegar aquí
        return const ConfiguracionView(); // Solo accesible desde TopBar
      case 6: // NUEVO: Case para perfil
        return const PerfilView(); // Vista de perfil
      default:
        return const DashboardContent();
    }
  }

  // Widget temporal para las secciones que aún no están implementadas
  Widget _buildPlaceholderView({
    required String title,
    required IconData icon,
    required String description,
  }) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 80,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              title,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppTheme.getTextPrimary(context),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.getTextSecondary(context),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => setState(() => selectedIndex = 0),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Volver al Dashboard',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}