import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/asociado.dart';
import '../widgets/dashboard/modules/gestion_asociados/shared/dialogs/new_asociado_dialog.dart';

class AsociadosController extends GetxController {
  // Variables observables
  RxBool isLoading = false.obs;
  Rxn<Asociado> selectedAsociado = Rxn<Asociado>();
  RxString searchQuery = ''.obs;
  RxList<Asociado> asociados = <Asociado>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAsociados();
  }

  // Cargar todos los asociados
  Future<void> loadAsociados() async {
    try {
      isLoading.value = true;
      Get.log('=== INICIANDO CARGA DE ASOCIADOS ===');
      
      // Usar FirebaseFirestore directamente
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('asociados')
          .get();
      
      Get.log('=== DOCUMENTOS ENCONTRADOS: ${snapshot.docs.length} ===');
      
      asociados.clear();
      for (var doc in snapshot.docs) {
        Get.log('=== PROCESANDO DOC: ${doc.id} ===');
        final asociado = Asociado.fromMap(
          doc.data() as Map<String, dynamic>, 
          doc.id
        );
        asociados.add(asociado);
        Get.log('=== AGREGADO: ${asociado.nombreCompleto} ===');
      }
      
      Get.log('=== TOTAL ASOCIADOS EN LISTA: ${asociados.length} ===');
    } catch (e) {
      Get.log('=== ERROR CARGANDO ASOCIADOS: $e ===');
      _showErrorSnackbar("Error", "No se pudieron cargar los asociados: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Crear nuevo asociado
  Future<bool> createAsociado({
    required String nombre,
    required String apellido,
    required String rut,
    required DateTime fechaNacimiento,
    required String estadoCivil,
    required String email,
    required String telefono,
    required String direccion,
    required String plan,
  }) async {
    try {
      isLoading.value = true;

      // Validaciones
      if (!Asociado.validarRUT(rut)) {
        _showErrorSnackbar("Error", "RUT inválido. Formato: 12345678-9");
        return false;
      }

      if (!Asociado.validarEmail(email)) {
        _showErrorSnackbar("Error", "Email inválido");
        return false;
      }

      // Verificar que el RUT no exista
      final existingAsociado = asociados.firstWhereOrNull(
        (asociado) => asociado.rut == rut
      );
      
      if (existingAsociado != null) {
        _showErrorSnackbar("Error", "Ya existe un asociado con este RUT");
        return false;
      }

      // Crear objeto Asociado
      final nuevoAsociado = Asociado(
        nombre: nombre.trim(),
        apellido: apellido.trim(),
        rut: rut.trim(),
        fechaNacimiento: fechaNacimiento,
        estadoCivil: estadoCivil,
        email: email.trim().toLowerCase(),
        telefono: telefono.trim(),
        direccion: direccion.trim(),
        plan: plan,
        fechaCreacion: DateTime.now(),
        fechaIngreso: DateTime.now(),
      );

      // Guardar en Firestore
      final docRef = await FirebaseFirestore.instance
          .collection('asociados')
          .add(nuevoAsociado.toMap());

      // Actualizar el objeto con el ID generado
      final asociadoConId = nuevoAsociado.copyWith(id: docRef.id);
      
      // Agregar a la lista local
      asociados.add(asociadoConId);
      
      // Seleccionar el nuevo asociado
      selectedAsociado.value = asociadoConId;
      searchQuery.value = rut;

      _showSuccessSnackbar("¡Éxito!", "Asociado creado correctamente");
      Get.log('Asociado creado: ${asociadoConId.nombreCompleto}');
      
      return true;

    } catch (e) {
      Get.log('Error creando asociado: $e');
      _showErrorSnackbar("Error", "No se pudo crear el asociado: ${e.toString()}");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Buscar asociado por RUT
  Future<void> searchAsociado(String rut) async {
    if (rut.isEmpty) {
      selectedAsociado.value = null;
      searchQuery.value = '';
      return;
    }
    
    isLoading.value = true;
    searchQuery.value = rut;

    try {
      // Buscar en la lista local primero
      final asociado = asociados.firstWhereOrNull(
        (asociado) => asociado.rut == rut || asociado.rutFormateado == rut
      );

      if (asociado != null) {
        selectedAsociado.value = asociado;
        _showSuccessSnackbar("Encontrado", "Asociado encontrado: ${asociado.nombreCompleto}");
      } else {
        // Si no está en local, buscar en Firestore
        final QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('asociados')
            .where('rut', isEqualTo: rut)
            .limit(1)
            .get();

        if (snapshot.docs.isNotEmpty) {
          final doc = snapshot.docs.first;
          final asociadoEncontrado = Asociado.fromMap(
            doc.data() as Map<String, dynamic>, 
            doc.id
          );
          
          selectedAsociado.value = asociadoEncontrado;
          
          // Agregar a la lista local si no está
          if (!asociados.any((a) => a.id == asociadoEncontrado.id)) {
            asociados.add(asociadoEncontrado);
          }
          
          _showSuccessSnackbar("Encontrado", "Asociado encontrado: ${asociadoEncontrado.nombreCompleto}");
        } else {
          selectedAsociado.value = null;
          _showErrorSnackbar("No encontrado", "No se encontró ningún asociado con RUT: $rut");
        }
      }
    } catch (e) {
      Get.log('Error buscando asociado: $e');
      _showErrorSnackbar("Error", "Error al buscar asociado");
      selectedAsociado.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  // Actualizar asociado
  Future<bool> updateAsociado(Asociado asociado) async {
    try {
      isLoading.value = true;

      if (asociado.id == null) {
        _showErrorSnackbar("Error", "No se puede actualizar: ID de asociado no válido");
        return false;
      }

      // Actualizar en Firestore
      await FirebaseFirestore.instance
          .collection('asociados')
          .doc(asociado.id)
          .update(asociado.toMap());

      // Actualizar en la lista local
      final index = asociados.indexWhere((a) => a.id == asociado.id);
      if (index != -1) {
        asociados[index] = asociado;
      }

      // Actualizar el seleccionado si es el mismo
      if (selectedAsociado.value?.id == asociado.id) {
        selectedAsociado.value = asociado;
      }

      _showSuccessSnackbar("¡Éxito!", "Asociado actualizado correctamente");
      return true;

    } catch (e) {
      Get.log('Error actualizando asociado: $e');
      _showErrorSnackbar("Error", "No se pudo actualizar el asociado");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Eliminar asociado
  Future<bool> deleteAsociadoById(String id) async {
    try {
      isLoading.value = true;

      // Eliminar de Firestore
      await FirebaseFirestore.instance
          .collection('asociados')
          .doc(id)
          .delete();

      // Eliminar de la lista local
      asociados.removeWhere((asociado) => asociado.id == id);

      // Limpiar selección si era el asociado seleccionado
      if (selectedAsociado.value?.id == id) {
        selectedAsociado.value = null;
        searchQuery.value = '';
      }

      _showSuccessSnackbar("Eliminado", "Asociado eliminado correctamente");
      return true;

    } catch (e) {
      Get.log('Error eliminando asociado: $e');
      _showErrorSnackbar("Error", "No se pudo eliminar el asociado");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Método para búsqueda biométrica
  Future<void> biometricSearch() async {
    isLoading.value = true;
    
    try {
      // Simular lectura biométrica
      await Future.delayed(const Duration(seconds: 3));
      
      // Por ahora simular que encontró un usuario (usar el primer asociado disponible)
      if (asociados.isNotEmpty) {
        final primerAsociado = asociados.first;
        await searchAsociado(primerAsociado.rut);
      } else {
        _showErrorSnackbar("Sin datos", "No hay asociados registrados para la búsqueda biométrica");
      }
    } catch (e) {
      _showErrorSnackbar("Error", "Error en búsqueda biométrica");
    } finally {
      isLoading.value = false;
    }
  }

  // Método para escaneo QR
  Future<void> qrCodeSearch() async {
    isLoading.value = true;
    
    try {
      // Simular escaneo QR
      await Future.delayed(const Duration(seconds: 2));
      
      // Por ahora simular que escaneó un RUT (usar un asociado aleatorio)
      if (asociados.isNotEmpty) {
        final asociadoAleatorio = asociados[
          DateTime.now().millisecond % asociados.length
        ];
        await searchAsociado(asociadoAleatorio.rut);
      } else {
        _showErrorSnackbar("Sin datos", "No hay asociados registrados para el escaneo QR");
      }
    } catch (e) {
      _showErrorSnackbar("Error", "Error en escaneo QR");
    } finally {
      isLoading.value = false;
    }
  }

  // Método para limpiar búsqueda
  void clearSearch() {
    selectedAsociado.value = null;
    searchQuery.value = '';
  }

  // Método para eliminar asociado (wrapper para la UI)
  void deleteAsociado() {
    if (selectedAsociado.value?.id != null) {
      deleteAsociadoById(selectedAsociado.value!.id!);
    }
  }

  // Métodos para acciones (por implementar después)
  void editAsociado() {
    Get.snackbar(
      'Editar Asociado', 
      'Función para editar asociado (próximamente)',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void addCarga() {
    Get.snackbar(
      'Agregar Carga', 
      'Función para agregar carga familiar (próximamente)',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void viewHistory() {
    Get.snackbar(
      'Ver Historial', 
      'Función para ver historial (próximamente)',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void generateQR() {
    Get.snackbar(
      'Generar QR', 
      'Código QR generado exitosamente',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.primary.withValues(alpha: 0.8),
      colorText: Get.theme.colorScheme.onPrimary,
    );
  }

  void newAsociado() {
    NewAsociadoDialog.show(Get.context!);
  }

  // Helpers para mostrar mensajes
  void _showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title, 
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.error.withValues(alpha: 0.8),
      colorText: Get.theme.colorScheme.onError,
      duration: const Duration(seconds: 4),
    );
  }

  void _showSuccessSnackbar(String title, String message) {
    Get.snackbar(
      title, 
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.primary.withValues(alpha: 0.8),
      colorText: Get.theme.colorScheme.onPrimary,
      duration: const Duration(seconds: 3),
    );
  }

  // Getters útiles
  bool get hasSelectedAsociado => selectedAsociado.value != null;
  String get currentSearchQuery => searchQuery.value;
  Asociado? get currentAsociado => selectedAsociado.value;
  int get totalAsociados => asociados.length;
  bool get hasAsociados => asociados.isNotEmpty;
}