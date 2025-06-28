import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/theme_controller.dart';
import '../controllers/asociados_controller.dart';
// NUEVA IMPORTACIÓN - Controller de Cargas Familiares
import '../controllers/cargas_familiares_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    // Registrar controladores permanentes para el dashboard
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<ThemeController>(ThemeController(), permanent: true);
    
    // Registrar el controlador de asociados como permanente
    // para mantener el estado entre navegaciones
    Get.put<AsociadosController>(AsociadosController(), permanent: true);
    
    // NUEVO - Registrar el controlador de cargas familiares como permanente
    Get.put<CargasFamiliaresController>(CargasFamiliaresController(), permanent: true);
  }
}