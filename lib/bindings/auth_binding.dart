import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/theme_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Registrar AuthController como singleton permanente
    Get.put<AuthController>(AuthController(), permanent: true);
    
    // Registrar ThemeController también
    Get.put<ThemeController>(ThemeController(), permanent: true);
  }
}