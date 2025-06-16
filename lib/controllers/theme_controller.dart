import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  // Opciones de tema
  static const int systemTheme = 0;
  static const int lightTheme = 1;
  static const int darkTheme = 2;

  // Estado reactivo del tema actual
  var currentTheme = systemTheme.obs;

  // Getter para obtener el ThemeMode actual
  ThemeMode get themeMode {
    switch (currentTheme.value) {
      case lightTheme:
        return ThemeMode.light;
      case darkTheme:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  // Método para cambiar el tema
  void changeTheme(int theme) {
    currentTheme.value = theme;
    Get.changeThemeMode(themeMode);
  }

  // Método para alternar entre claro y oscuro
  void toggleTheme() {
    if (currentTheme.value == lightTheme) {
      changeTheme(darkTheme);
    } else if (currentTheme.value == darkTheme) {
      changeTheme(lightTheme);
    } else {
      // Si está en sistema, cambia a modo claro
      changeTheme(lightTheme);
    }
  }

  // Método para volver al tema del sistema
  void setSystemTheme() {
    changeTheme(systemTheme);
  }

  // Getter para saber si el tema actual es oscuro
  bool get isDarkMode {
    if (currentTheme.value == darkTheme) return true;
    if (currentTheme.value == lightTheme) return false;
    // Si es sistema, detecta el tema actual
    return Get.isDarkMode;
  }

  // Getter para el ícono del botón
  IconData get themeIcon {
    switch (currentTheme.value) {
      case lightTheme:
        return Icons.light_mode;
      case darkTheme:
        return Icons.dark_mode;
      default:
        return Icons.brightness_auto;
    }
  }

  // Getter para el tooltip del botón
  String get themeTooltip {
    switch (currentTheme.value) {
      case lightTheme:
        return 'Modo claro';
      case darkTheme:
        return 'Modo oscuro';
      default:
        return 'Tema automático';
    }
  }
}