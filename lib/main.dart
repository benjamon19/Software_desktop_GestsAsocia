import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'utils/app_routes.dart';
import 'utils/app_theme.dart';
import 'controllers/theme_controller.dart';

void main() {
  // Inicializar el controlador de tema
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    
    return Obx(() => GetMaterialApp(
      title: 'GestAsocia',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeController.themeMode,
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
    ));
  }
}