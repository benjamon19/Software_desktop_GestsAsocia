import 'package:cloud_firestore/cloud_firestore.dart';

class CargaFamiliar {
  String? id;
  String asociadoId; // Referencia al asociado titular
  String nombre;
  String apellido;
  String rut;
  String parentesco;
  DateTime fechaNacimiento;
  DateTime fechaCreacion;
  bool isActive;

  CargaFamiliar({
    this.id,
    required this.asociadoId,
    required this.nombre,
    required this.apellido,
    required this.rut,
    required this.parentesco,
    required this.fechaNacimiento,
    required this.fechaCreacion,
    this.isActive = true,
  });

  // Getters útiles
  String get nombreCompleto => '$nombre $apellido';
  
  String get rutFormateado {
    if (rut.length < 2) return rut;
    String cuerpo = rut.substring(0, rut.length - 1);
    String dv = rut.substring(rut.length - 1);
    
    // Formatear cuerpo con puntos
    String cuerpoFormateado = '';
    for (int i = cuerpo.length - 1; i >= 0; i--) {
      if ((cuerpo.length - i) % 3 == 1 && i != cuerpo.length - 1) {
        cuerpoFormateado = '.$cuerpoFormateado';
      }
      cuerpoFormateado = '${cuerpo[i]}$cuerpoFormateado';
    }
    
    return '$cuerpoFormateado-$dv';
  }

  String get fechaNacimientoFormateada {
    return '${fechaNacimiento.day.toString().padLeft(2, '0')}/'
           '${fechaNacimiento.month.toString().padLeft(2, '0')}/'
           '${fechaNacimiento.year}';
  }

  String get fechaCreacionFormateada {
    return '${fechaCreacion.day.toString().padLeft(2, '0')}/'
           '${fechaCreacion.month.toString().padLeft(2, '0')}/'
           '${fechaCreacion.year}';
  }

  String get estado => isActive ? 'Activa' : 'Inactiva';

  // Calcular edad
  int get edad {
    final now = DateTime.now();
    int age = now.year - fechaNacimiento.year;
    if (now.month < fechaNacimiento.month || 
        (now.month == fechaNacimiento.month && now.day < fechaNacimiento.day)) {
      age--;
    }
    return age;
  }

  // Validación de RUT chileno (reutilizada del modelo Asociado)
  static bool validarRUT(String rut) {
    try {
      // Limpiar RUT (quitar puntos y guión)
      String rutLimpio = rut.replaceAll(RegExp(r'[^0-9kK]'), '');
      
      if (rutLimpio.length < 2) return false;
      
      String cuerpo = rutLimpio.substring(0, rutLimpio.length - 1);
      String dv = rutLimpio.substring(rutLimpio.length - 1).toUpperCase();
      
      // Validar que el cuerpo sean solo números
      if (!RegExp(r'^[0-9]+$').hasMatch(cuerpo)) return false;
      
      // Calcular dígito verificador
      int suma = 0;
      int multiplicador = 2;
      
      for (int i = cuerpo.length - 1; i >= 0; i--) {
        suma += int.parse(cuerpo[i]) * multiplicador;
        multiplicador = multiplicador == 7 ? 2 : multiplicador + 1;
      }
      
      int resto = suma % 11;
      String dvCalculado = resto == 0 ? '0' : resto == 1 ? 'K' : (11 - resto).toString();
      
      return dv == dvCalculado;
    } catch (e) {
      return false;
    }
  }

  // Validar parentesco
  static bool validarParentesco(String parentesco) {
    final parentescosValidos = [
      'Hijo/a', 'Cónyuge', 'Padre', 'Madre', 'Hermano/a', 
      'Abuelo/a', 'Nieto/a', 'Tío/a', 'Sobrino/a', 'Otro'
    ];
    return parentescosValidos.contains(parentesco);
  }

  // Convertir a Map para Firestore
  Map<String, dynamic> toMap() {
    return {
      'asociadoId': asociadoId,
      'nombre': nombre,
      'apellido': apellido,
      'rut': rut,
      'parentesco': parentesco,
      'fechaNacimiento': fechaNacimiento,
      'fechaCreacion': fechaCreacion,
      'isActive': isActive,
    };
  }

  // Crear desde Map de Firestore
  factory CargaFamiliar.fromMap(Map<String, dynamic> map, String id) {
    return CargaFamiliar(
      id: id,
      asociadoId: map['asociadoId'] ?? '',
      nombre: map['nombre'] ?? '',
      apellido: map['apellido'] ?? '',
      rut: map['rut'] ?? '',
      parentesco: map['parentesco'] ?? '',
      fechaNacimiento: _parseDateTime(map['fechaNacimiento']),
      fechaCreacion: _parseDateTime(map['fechaCreacion']),
      isActive: map['isActive'] ?? true,
    );
  }

  // Helper para manejar diferentes tipos de fecha
  static DateTime _parseDateTime(dynamic fecha) {
    if (fecha == null) return DateTime.now();
    
    if (fecha is DateTime) {
      return fecha;
    } else if (fecha is String) {
      try {
        return DateTime.parse(fecha);
      } catch (e) {
        return DateTime.now();
      }
    } else if (fecha is Timestamp) {
      // Para Timestamp de Firestore
      return fecha.toDate();
    } else {
      return DateTime.now();
    }
  }

  // Crear copia con cambios
  CargaFamiliar copyWith({
    String? id,
    String? asociadoId,
    String? nombre,
    String? apellido,
    String? rut,
    String? parentesco,
    DateTime? fechaNacimiento,
    DateTime? fechaCreacion,
    bool? isActive,
  }) {
    return CargaFamiliar(
      id: id ?? this.id,
      asociadoId: asociadoId ?? this.asociadoId,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      rut: rut ?? this.rut,
      parentesco: parentesco ?? this.parentesco,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  String toString() {
    return 'CargaFamiliar{id: $id, nombreCompleto: $nombreCompleto, rut: $rutFormateado, parentesco: $parentesco}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CargaFamiliar && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}