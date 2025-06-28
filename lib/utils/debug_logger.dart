import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/foundation.dart';

class DebugLogger {
  static bool _suppressFirebaseWarnings = true;

  /// Configura si suprimir los warnings de Firebase en desktop
  static void setSuppressFirebaseWarnings(bool suppress) {
    _suppressFirebaseWarnings = suppress;
  }

  /// Log personalizado que filtra warnings de Firebase en desktop
  static void log(String message, {
    String? name,
    Object? error,
    StackTrace? stackTrace,
    int level = 0,
  }) {
    // Solo aplicar filtros en plataformas desktop y modo debug
    if (_suppressFirebaseWarnings && 
        kDebugMode && 
        (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
      
      // Lista de patrones de warnings de Firebase que queremos suprimir
      const firebaseWarningPatterns = [
        'firebase_auth_plugin/auth-state',
        'firebase_auth_plugin/id-token',
        'plugins.flutter.io/firebase_firestore',
        'non-platform thread',
        'Platform channel messages must be sent on the platform thread',
      ];

      // Verificar si el mensaje contiene algún patrón de warning de Firebase
      bool isFirebaseWarning = firebaseWarningPatterns.any(
        (pattern) => message.toLowerCase().contains(pattern.toLowerCase())
      );

      // Si es un warning de Firebase, solo loggear en nivel muy bajo
      if (isFirebaseWarning) {
        if (kDebugMode) {
          // Solo mostrar en debug muy verboso
          developer.log(
            '[SUPPRESSED FIREBASE WARNING] $message',
            name: name ?? 'FirebaseDesktop',
            level: 100, // Nivel muy bajo
          );
        }
        return;
      }
    }

    // Para otros mensajes, usar el logging normal
    developer.log(
      message,
      name: name ?? 'App',
      error: error,
      stackTrace: stackTrace,
      level: level,
    );
  }
}

/// Extension para facilitar el uso
extension LogExtension on String {
  void logInfo() => DebugLogger.log(this, level: 800);
  void logWarning() => DebugLogger.log(this, level: 900);
  void logError() => DebugLogger.log(this, level: 1000);
}