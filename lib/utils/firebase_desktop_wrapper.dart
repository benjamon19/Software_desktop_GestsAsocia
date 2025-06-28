import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'debug_logger.dart';

/// Wrapper para manejar Firebase en aplicaciones desktop
/// con manejo mejorado de warnings y errores específicos de plataforma
class FirebaseDesktopWrapper {
  static bool get isDesktop => Platform.isWindows || Platform.isLinux || Platform.isMacOS;

  /// Wrapper para Firebase Auth con manejo de warnings
  static FirebaseAuth get auth {
    try {
      return FirebaseAuth.instance;
    } catch (e) {
      if (isDesktop && kDebugMode) {
        DebugLogger.log('Warning Firebase Auth en desktop: $e');
        // En desktop, algunos warnings son esperados
        return FirebaseAuth.instance;
      }
      rethrow;
    }
  }

  /// Wrapper para Firestore con manejo de warnings
  static FirebaseFirestore get firestore {
    try {
      return FirebaseFirestore.instance;
    } catch (e) {
      if (isDesktop && kDebugMode) {
        DebugLogger.log('Warning Firestore en desktop: $e');
        // En desktop, algunos warnings son esperados
        return FirebaseFirestore.instance;
      }
      rethrow;
    }
  }

  /// Stream de estado de autenticación con manejo de errores mejorado
  static Stream<User?> get authStateChanges {
    if (isDesktop) {
      return auth.authStateChanges().handleError((error) {
        if (kDebugMode) {
          DebugLogger.log('Error en authStateChanges (desktop): $error');
        }
        // En desktop, algunos errores pueden ser warnings no críticos
        return null;
      });
    }
    return auth.authStateChanges();
  }

  /// Método de login con manejo mejorado para desktop
  static Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (isDesktop) {
        DebugLogger.log('Login exitoso en desktop para: $email');
      }
      
      return result;
    } catch (e) {
      if (isDesktop && kDebugMode) {
        DebugLogger.log('Error de login en desktop: $e', error: e);
      }
      rethrow;
    }
  }

  /// Método de registro con manejo mejorado para desktop
  static Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (isDesktop) {
        DebugLogger.log('Registro exitoso en desktop para: $email');
      }
      
      return result;
    } catch (e) {
      if (isDesktop && kDebugMode) {
        DebugLogger.log('Error de registro en desktop: $e', error: e);
      }
      rethrow;
    }
  }

  /// Método de logout con manejo mejorado para desktop
  static Future<void> signOut() async {
    try {
      await auth.signOut();
      
      if (isDesktop) {
        DebugLogger.log('Logout exitoso en desktop');
      }
    } catch (e) {
      if (isDesktop && kDebugMode) {
        DebugLogger.log('Error de logout en desktop: $e', error: e);
      }
      rethrow;
    }
  }

  /// Wrapper para operaciones de Firestore con manejo de errores
  static DocumentReference doc(String path) {
    try {
      return firestore.doc(path);
    } catch (e) {
      if (isDesktop && kDebugMode) {
        DebugLogger.log('Warning Firestore doc en desktop: $e');
      }
      rethrow;
    }
  }

  /// Wrapper para colecciones de Firestore
  static CollectionReference collection(String path) {
    try {
      return firestore.collection(path);
    } catch (e) {
      if (isDesktop && kDebugMode) {
        DebugLogger.log('Warning Firestore collection en desktop: $e');
      }
      rethrow;
    }
  }

  /// Configuración específica para desktop
  static Future<void> configureForDesktop() async {
    if (!isDesktop) return;

    try {
      // Configuraciones específicas para desktop
      if (kDebugMode) {
        DebugLogger.log('Configurando Firebase para plataforma desktop');
        
        // Configurar timeouts más largos para desktop
        // Esto puede ayudar con algunos warnings de threading
        await firestore.enableNetwork();
        
        DebugLogger.log('Firebase configurado para desktop');
      }
    } catch (e) {
      if (kDebugMode) {
        DebugLogger.log('Error configurando Firebase para desktop: $e');
      }
      // No rethrow aquí, ya que puede ser un warning no crítico
    }
  }

  /// Obtener información de la plataforma actual
  static Map<String, dynamic> getPlatformInfo() {
    return {
      'platform': Platform.operatingSystem,
      'isDesktop': isDesktop,
      'isDebugMode': kDebugMode,
      'version': Platform.version,
    };
  }
}