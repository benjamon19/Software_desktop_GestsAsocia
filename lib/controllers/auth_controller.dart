import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/usuario.dart';
import '../services/firebase_service.dart';

class AuthController extends GetxController {
  // Variables observables
  Rxn<User> firebaseUser = Rxn<User>();
  Rxn<Usuario> currentUser = Rxn<Usuario>();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Usando Get.log para logging en desarrollo
    Get.log('=== INICIALIZANDO AUTH CONTROLLER ===');
    
    // Escuchar cambios en el estado de autenticación
    firebaseUser.bindStream(FirebaseService.authStateChanges);
    
    // Cuando el usuario de Firebase cambia, cargar sus datos
    ever(firebaseUser, _handleAuthChanged);
  }

  // Manejar cambios de autenticación
  void _handleAuthChanged(User? user) async {
    Get.log('=== CAMBIO DE ESTADO AUTH ===');
    Get.log('Usuario: ${user?.email ?? "null"}');

    if (user != null) {
      // Usuario logueado - cargar sus datos
      await _loadUserData(user.uid);

      // Navegar al dashboard si los datos se cargan correctamente
      if (currentUser.value != null) {
        Get.log('=== NAVEGANDO A DASHBOARD ===');
        Get.offAllNamed('/dashboard');
      }
    } else {
      // Usuario deslogueado - limpiar datos
      currentUser.value = null;
      Get.log('=== USUARIO DESLOGUEADO ===');
    }
  }

  // Cargar datos del usuario
  Future<void> _loadUserData(String uid) async {
    try {
      Get.log('=== CARGANDO DATOS DEL USUARIO ===');
      Usuario? usuario = await FirebaseService.getUser(uid);
      currentUser.value = usuario;
      Get.log('=== DATOS CARGADOS: ${usuario?.nombreCompleto} ===');
    } catch (e) {
      Get.log('=== ERROR CARGANDO DATOS ===');
      Get.log('Error: $e');
      _showErrorSnackbar("Error", "No se pudieron cargar los datos del usuario");
    }
  }

  // Registro de usuario - CON SOPORTE PARA RUT COMO LOGIN
  Future<bool> register({
    required String email,
    required String password,
    required String nombre,
    required String apellido,
    required String telefono,
    required String rut,
  }) async {
    try {
      Get.log('=== INICIANDO PROCESO DE REGISTRO ===');
      isLoading.value = true;

      // Validar RUT
      if (!Usuario.validarRUT(rut)) {
        _showErrorSnackbar("Error", "RUT inválido. Formato: 12345678-9");
        return false;
      }

      // Paso 1: Crear usuario principal con email
      Get.log('=== PASO 1: CREANDO AUTH CON EMAIL ===');
      UserCredential result = await FirebaseService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Paso 2: Crear objeto Usuario
      Get.log('=== PASO 2: CREANDO OBJETO USUARIO ===');
      Usuario nuevoUsuario = Usuario(
        nombre: nombre,
        apellido: apellido,
        email: email,
        telefono: telefono,
        rut: rut,
        fechaCreacion: DateTime.now(),
      );

      // Paso 3: Guardar en Firestore
      Get.log('=== PASO 3: GUARDANDO EN FIRESTORE ===');
      await FirebaseService.saveUser(result.user!.uid, nuevoUsuario);

      // Paso 4: Crear entrada adicional para login con RUT
      Get.log('=== PASO 4: CREANDO ENTRADA PARA LOGIN CON RUT ===');
      try {
        await FirebaseService.createUserWithEmailAndPassword(
          email: '$rut@rut.local',
          password: password,
        );
        Get.log('Usuario RUT creado: $rut@rut.local');
      } catch (e) {
        Get.log('No se pudo crear usuario RUT (puede que ya exista): $e');
        // No es crítico si falla
      }

      Get.log('=== REGISTRO COMPLETADO EXITOSAMENTE ===');
      _showSuccessSnackbar("¡Éxito!", "Usuario registrado correctamente");
      return true;

    } catch (e) {
      Get.log('=== ERROR EN REGISTRO COMPLETO ===');
      Get.log('Error: $e');
      
      String errorMessage = _extractErrorMessage(e);
      _showErrorSnackbar("Error de Registro", errorMessage);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Login de usuario - SIMPLE CON BÚSQUEDA EN FIRESTORE
  Future<bool> login(String input, String password) async {
    try {
      Get.log('LOGIN - Input: "$input"');
      isLoading.value = true;

      if (input.trim().isEmpty || password.isEmpty) {
        _showErrorSnackbar("Error", "Completa todos los campos");
        return false;
      }

      String emailParaLogin = input.trim();

      // Si NO tiene @ (es RUT), buscar el email en Firestore
      if (!input.contains('@')) {
        Get.log('Es RUT, buscando email en Firestore...');
        
        final usuarios = await FirebaseService.getCollection('usuarios');
        
        for (var doc in usuarios.docs) {
          final userData = doc.data() as Map<String, dynamic>;
          if (userData['rut'] == input) {
            emailParaLogin = userData['email'];
            Get.log('Email encontrado: $emailParaLogin');
            break;
          }
        }
        
        if (emailParaLogin == input) {
          _showErrorSnackbar("Error", "No se encontró cuenta con RUT: $input");
          return false;
        }
      }

      Get.log('Haciendo login con email: $emailParaLogin');

      await FirebaseService.signInWithEmailAndPassword(
        email: emailParaLogin,
        password: password,
      );

      _showSuccessSnackbar("¡Éxito!", "Sesión iniciada correctamente");
      return true;

    } catch (e) {
      Get.log('ERROR LOGIN: $e');
      String errorMessage = _extractErrorMessage(e);
      _showErrorSnackbar("Error de Login", errorMessage);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Cerrar sesión
  Future<void> logout() async {
    try {
      await FirebaseService.signOut();
      _showSuccessSnackbar("Sesión cerrada", "Has cerrado sesión correctamente");
      Get.offAllNamed('/login');
    } catch (e) {
      String errorMessage = _extractErrorMessage(e);
      _showErrorSnackbar("Error", "Error al cerrar sesión: $errorMessage");
    }
  }

  // ========== HELPERS PARA MANEJO DE ERRORES ==========

  /// Extraer mensaje de error limpio
  String _extractErrorMessage(dynamic error) {
    if (error is Exception) {
      return error.toString().replaceFirst('Exception: ', '');
    }
    return error.toString();
  }

  /// Mostrar snackbar de error
  void _showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title, 
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.error,
      colorText: Get.theme.colorScheme.onError,
      duration: const Duration(seconds: 4),
    );
  }

  /// Mostrar snackbar de éxito
  void _showSuccessSnackbar(String title, String message) {
    Get.snackbar(
      title, 
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.primary,
      colorText: Get.theme.colorScheme.onPrimary,
      duration: const Duration(seconds: 3),
    );
  }

  // Getters útiles
  bool get isSignedIn => firebaseUser.value != null;
  String? get currentUserId => FirebaseService.currentUserId;
  String get userDisplayName => currentUser.value?.nombreCompleto ?? 'Usuario';
  String get userEmail => currentUser.value?.email ?? '';
}