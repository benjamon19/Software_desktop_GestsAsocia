import 'package:get/get.dart';
import '../widgets/dashboard/modules/gestion_asociados/shared//dialogs/new_asociado_dialog.dart';

class AsociadosController extends GetxController {
  // Variables observables
  RxBool isLoading = false.obs;
  Rxn<Map<String, dynamic>> selectedAsociado = Rxn<Map<String, dynamic>>();
  RxString searchQuery = ''.obs;

  // Método para buscar asociado
  Future<void> searchAsociado(String rut) async {
    if (rut.isEmpty) return;
    
    isLoading.value = true;
    searchQuery.value = rut;

    // Simular búsqueda - aquí integrarías con tu backend
    await Future.delayed(const Duration(seconds: 2));
    
    // Datos de ejemplo (mantenemos los mismos datos)
    selectedAsociado.value = {
      'rut': rut,
      'nombre': 'Juan Carlos',
      'apellido': 'González Pérez',
      'email': 'juan.gonzalez@email.com',
      'telefono': '+56 9 1234 5678',
      'fechaNacimiento': '15/08/1985',
      'direccion': 'Av. Principal 123, Santiago',
      'estadoCivil': 'Casado',
      'fechaIngreso': '01/03/2020',
      'estado': 'Activo',
      'plan': 'Premium', // Se convertirá a VIP en el display
      'cargasFamiliares': [
        {
          'nombre': 'María González',
          'parentesco': 'Cónyuge',
          'rut': '87654321-0',
          'fechaNacimiento': '22/11/1987',
        },
        {
          'nombre': 'Sofía González',
          'parentesco': 'Hija',
          'rut': '12345678-9',
          'fechaNacimiento': '10/05/2015',
        },
        {
          'nombre': 'Diego González',
          'parentesco': 'Hijo',
          'rut': '23456789-1',
          'fechaNacimiento': '03/03/2018',
        },
        {
          'nombre': 'Elena González',
          'parentesco': 'Madre',
          'rut': '98765432-1',
          'fechaNacimiento': '15/12/1955',
        },
        {
          'nombre': 'Carlos González',
          'parentesco': 'Padre',
          'rut': '87654321-2',
          'fechaNacimiento': '28/07/1952',
        },
        {
          'nombre': 'Ana González',
          'parentesco': 'Hermana',
          'rut': '76543210-9',
          'fechaNacimiento': '05/09/1982',
        },
      ],
    };
    
    isLoading.value = false;
  }

  // Método para búsqueda biométrica
  Future<void> biometricSearch() async {
    isLoading.value = true;
    
    // Simular lectura biométrica
    await Future.delayed(const Duration(seconds: 3));
    
    // Por ahora simular que encontró un usuario
    await searchAsociado('12345678-9');
  }

  // Método para escaneo QR
  Future<void> qrCodeSearch() async {
    isLoading.value = true;
    
    // Simular escaneo QR
    await Future.delayed(const Duration(seconds: 2));
    
    // Por ahora simular que escaneó un RUT
    await searchAsociado('98765432-1');
  }

  // Método para limpiar búsqueda
  void clearSearch() {
    selectedAsociado.value = null;
    searchQuery.value = '';
  }

  // Método para eliminar asociado
  void deleteAsociado() {
    selectedAsociado.value = null;
    searchQuery.value = '';
    
    Get.snackbar(
      'Asociado Eliminado', 
      'El asociado ha sido eliminado del sistema',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.error.withValues(alpha: 0.8),
      colorText: Get.theme.colorScheme.onError,
    );
  }

  // Métodos para acciones (por ahora solo muestran snackbars)
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

  // Getters útiles
  bool get hasSelectedAsociado => selectedAsociado.value != null;
  String get currentSearchQuery => searchQuery.value;
  Map<String, dynamic>? get currentAsociado => selectedAsociado.value;
}