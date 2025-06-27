// lib/config/app_initializer.dart
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_config.dart';
import 'window_config.dart';
import '../controllers/auth_controller.dart';
import '../controllers/theme_controller.dart';
import '../utils/debug_logger.dart';
import '../utils/desktop_setup.dart';
import '../utils/firebase_desktop_wrapper.dart';
import '../utils/firebase_warning_suppressor.dart';

/// Clase centralizada para inicialización de la aplicación
class AppInitializer {
  
  /// Inicializar toda la aplicación
  static Future<void> initialize() async {
    await _configureDesktop();
    await _configureWindow();
    await _initializeFirebase();
    _initializeControllers();
    await _postInitializationSetup();
  }

  /// Configurar entorno desktop si es necesario
  static Future<void> _configureDesktop() async {
    if (!_isDesktop) return;

    await DesktopSetup.configure();
    
    // Configurar supresor de warnings específico para Firebase
    FirebaseWarningSuppressor.configureForFirebaseAuth();
    FirebaseWarningSuppressor.showWarningInfo();
    
    DesktopSetup.showDesktopTips();
    
    if (kDebugMode) {
      DebugLogger.setSuppressFirebaseWarnings(true);
      DebugLogger.log('Aplicación desktop iniciada con configuración optimizada');
    }
  }

  /// Configurar ventana de escritorio
  static Future<void> _configureWindow() async {
    try {
      await WindowConfig.initialize();
      DebugLogger.log('Configuración de ventana completada');
    } catch (e) {
      DebugLogger.log('Error configurando ventana: $e', error: e);
    }
  }

  /// Inicializar Firebase con manejo robusto de errores
  static Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp(options: FirebaseConfig.webOptions);
      DebugLogger.log('Firebase inicializado correctamente');
      
      if (_isDesktop) {
        bool isValid = DesktopSetup.validateFirebaseSetup();
        if (isValid) {
          DebugLogger.log('Configuración Firebase desktop validada');
        }
      }
      
    } catch (e) {
      await _handleFirebaseInitializationError(e);
    }
  }

  /// Manejar errores de inicialización de Firebase
  static Future<void> _handleFirebaseInitializationError(dynamic e) async {
    DebugLogger.log('Error inicializando Firebase: $e', error: e);
    
    if (_isDesktop) {
      DebugLogger.log('Continuando en modo desktop con configuración alternativa...');
      
      try {
        await Firebase.initializeApp(
          name: 'desktop-fallback',
          options: FirebaseConfig.webOptions,
        );
        DebugLogger.log('Firebase inicializado con configuración alternativa');
      } catch (fallbackError) {
        DebugLogger.log('Error en configuración alternativa: $fallbackError');
        if (!kDebugMode) {
          throw Exception('Error crítico inicializando Firebase: $fallbackError');
        }
      }
    } else {
      throw Exception('Error inicializando Firebase: $e');
    }
  }

  /// Inicializar controladores de GetX
  static void _initializeControllers() {
    try {
      Get.put(ThemeController(), permanent: true);
      Get.put(AuthController(), permanent: true);
      DebugLogger.log('Controladores inicializados');
    } catch (e) {
      DebugLogger.log('Error inicializando controladores: $e', error: e);
      throw Exception('Error inicializando controladores: $e');
    }
  }

  /// Configuración posterior a la inicialización
  static Future<void> _postInitializationSetup() async {
    if (_isDesktop) {
      try {
        await FirebaseDesktopWrapper.configureForDesktop();
        DebugLogger.log('Wrapper Firebase desktop configurado');
      } catch (e) {
        DebugLogger.log('Warning configurando desktop wrapper: $e');
      }
    }
  }

  /// Verificar si estamos en plataforma desktop
  static bool get _isDesktop => 
      Platform.isWindows || Platform.isLinux || Platform.isMacOS;
}