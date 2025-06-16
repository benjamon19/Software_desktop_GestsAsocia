import 'package:get/get.dart';
import 'firebase_service.dart';

class AuthHelper {
  
  static Future<String> getEmailFromInput(String input) async {
    if (GetUtils.isEmail(input)) {
      return input;
    }
    
    if (isValidRUT(input)) {
      try {
        String? email = await findEmailByRUT(input);
        return email ?? '';
      } catch (e) {
        print('Error buscando email por RUT: $e');
        return '';
      }
    }
    
    return '';
  }

  static Future<String?> findEmailByRUT(String rut) async {
    try {
      final usuarios = await FirebaseService.getCollection('usuarios');
      
      for (var doc in usuarios.docs) {
        final userData = doc.data() as Map<String, dynamic>;
        if (userData['rut'] == rut) {
          return userData['email'];
        }
      }
      
      return null;
    } catch (e) {
      print('Error en consulta de RUT: $e');
      return null;
    }
  }

  static bool isValidRUT(String text) {
    if (text.length < 9 || text.length > 10) {
      return false;
    }
    
    if (!text.contains('-')) {
      return false;
    }
    
    List<String> parts = text.split('-');
    if (parts.length != 2) {
      return false;
    }
    
    String numbers = parts[0];
    String dv = parts[1];
    
    if (numbers.length < 7 || numbers.length > 8) {
      return false;
    }
    
    if (dv.length != 1) {
      return false;
    }
    
    for (int i = 0; i < numbers.length; i++) {
      String char = numbers[i];
      if (char != '0' && char != '1' && char != '2' && char != '3' && 
          char != '4' && char != '5' && char != '6' && char != '7' && 
          char != '8' && char != '9') {
        return false;
      }
    }
    
    if (dv != '0' && dv != '1' && dv != '2' && dv != '3' && 
        dv != '4' && dv != '5' && dv != '6' && dv != '7' && 
        dv != '8' && dv != '9' && dv != 'K' && dv != 'k') {
      return false;
    }
    
    return true;
  }

  static String? validateRegisterFields({
    required String nombre,
    required String apellido,
    required String rut,
    required String email,
    required String telefono,
    required String password,
    required String confirmPassword,
  }) {
    if (nombre.isEmpty || apellido.isEmpty || rut.isEmpty || 
        email.isEmpty || telefono.isEmpty || password.isEmpty || 
        confirmPassword.isEmpty) {
      return 'Todos los campos son obligatorios';
    }

    if (!GetUtils.isEmail(email)) {
      return 'Ingresa un email válido';
    }

    if (password != confirmPassword) {
      return 'Las contraseñas no coinciden';
    }

    if (password.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }

    return null;
  }
}