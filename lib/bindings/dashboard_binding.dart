import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/theme_controller.dart';
import '../controllers/asociados_controller.dart';
import '../controllers/cargas_familiares_controller.dart';
import '../controllers/historial_clinico_controller.dart';  // Comentar por ahora
//import '../controllers/perfil_controller.dart';  // Comentar por ahora
import '../controllers/configuracion_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<ThemeController>(ThemeController(), permanent: true);
    Get.put<AsociadosController>(AsociadosController(), permanent: true);
    Get.put<CargasFamiliaresController>(CargasFamiliaresController(), permanent: true);
    Get.put<HistorialClinicoController>(HistorialClinicoController(), permanent: true);  // Comentar por ahora
    //Get.put<PerfilController>(PerfilController(), permanent: true);  // Comentar por ahora
    Get.put<ConfiguracionController>(ConfiguracionController(), permanent: true);
  }
}