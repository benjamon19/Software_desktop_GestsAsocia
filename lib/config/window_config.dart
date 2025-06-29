// lib/config/window_config.dart
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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
        // Importación condicional de window_manager
        await _configureWindow();
      } catch (e) {
        if (kDebugMode) {
          print('Error configurando ventana: $e');
        }
        // No lanzar error si falla, continuar sin configuración de ventana
      }
    }
  }

  /// Configurar ventana usando window_manager (solo desktop)
  static Future<void> _configureWindow() async {
    try {
      // Solo importar window_manager si no es web
      final windowManager = await _getWindowManager();
      if (windowManager == null) return;

      await windowManager.ensureInitialized();

      const windowOptions = {
        'size': {'width': minWidth, 'height': minHeight},
        'minimumSize': {'width': minWidth, 'height': minHeight}, 
        'center': true,
        'backgroundColor': Colors.white,
        'skipTaskbar': false,
        'titleBarStyle': 'normal',
      };

      // Simular configuración de ventana
      if (kDebugMode) {
        print('Configurando ventana con opciones: $windowOptions');
      }

      // await windowManager.waitUntilReadyToShow(windowOptions, () async {
      //   await windowManager.show();
      //   await windowManager.focus();
      // });

      // await windowManager.setTitle('GestAsocia');
      
    } catch (e) {
      if (kDebugMode) {
        print('Error en configuración de ventana: $e');
      }
    }
  }

  /// Obtener window_manager de forma segura
  static Future<dynamic> _getWindowManager() async {
    try {
      // Por ahora retornamos null para evitar imports problemáticos
      // En el futuro se puede usar importación condicional
      return null;
    } catch (e) {
      return null;
    }
  }
}
