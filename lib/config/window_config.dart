import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:window_manager/window_manager.dart';

class WindowConfig {
  // Configuración de tamaños
  static const double minWidth = 1500.0;   
  static const double minHeight = 1000.0;   

  // Inicializar ventana
  static Future<void> initialize() async {
    // Solo ejecutar en desktop, NO en web
    if (kIsWeb) {
      if (kDebugMode) {
        print('Saltando configuración de ventana - ejecutando en web');
      }
      return;
    }

    // Solo configurar ventana en plataformas desktop
    if (defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      
      try {
        await _configureWindow();
      } catch (e) {
        if (kDebugMode) {
          print('Error configurando ventana: $e');
        }
        // No lanzar error si falla, continuar sin configuración de ventana
      }
    }
  }

  /// Configurar ventana usando window_manager
  static Future<void> _configureWindow() async {
    try {
      // Asegurar que window manager esté inicializado
      await windowManager.ensureInitialized();

      // Configurar opciones de ventana
      const WindowOptions windowOptions = WindowOptions(
        size: Size(minWidth, minHeight),
        minimumSize: Size(minWidth, minHeight),
        center: true,
        backgroundColor: Colors.transparent,
        skipTaskbar: false,
        titleBarStyle: TitleBarStyle.normal,
      );

      // Esperar hasta que esté listo para mostrar
      await windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.show();
        await windowManager.focus();
      });

      // Establecer título
      await windowManager.setTitle('GestAsocia');

      if (kDebugMode) {
        print('Window manager configurado correctamente');
      }
      
    } catch (e) {
      if (kDebugMode) {
        print('Error en configuración de window manager: $e');
      }
      // No relanzar el error para evitar crash de la app
    }
  }
}