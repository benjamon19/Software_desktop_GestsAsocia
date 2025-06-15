import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_theme.dart';
import '../widgets/interactive_link.dart';
import 'dart:math';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final rutController = TextEditingController();
  final emailController = TextEditingController();
  final telefonoController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool acceptTerms = false;
  bool isLoading = false;

  @override
  void dispose() {
    nombreController.dispose();
    apellidoController.dispose();
    rutController.dispose();
    emailController.dispose();
    telefonoController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppTheme.backgroundColor,
        child: Row(
          children: [
            // Panel izquierdo
            Expanded(
              flex: 5,
              child: Container(
                decoration: const BoxDecoration(color: AppTheme.secondaryColor),
                child: Stack(
                  children: [
                    Positioned.fill(child: CustomPaint(painter: BackgroundPainter())),
                    const Padding(
                      padding: EdgeInsets.all(60),
                      child: _LeftPanelContent(),
                    ),
                  ],
                ),
              ),
            ),
            // Panel derecho
            Expanded(
              flex: 4,
              child: Container(
                color: AppTheme.surfaceColor,
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(40),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 32),
                          // Header
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Crear Cuenta', style: AppTheme.headingMedium),
                              SizedBox(height: 8),
                              Text('Completa los datos para registrarte'),
                            ],
                          ),
                          const SizedBox(height: 32),
                          // Información Personal Header
                          const Row(
                            children: [
                              Icon(Icons.person, color: Colors.grey, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Información Personal',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Nombre y Apellido en fila
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: nombreController,
                                  keyboardType: TextInputType.name,
                                  decoration: _inputDecoration(
                                    'Nombre',
                                    'Tu nombre',
                                    Icons.person_outline,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TextFormField(
                                  controller: apellidoController,
                                  keyboardType: TextInputType.name,
                                  decoration: _inputDecoration(
                                    'Apellido',
                                    'Tu apellido',
                                    Icons.person_outline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // RUT field
                          TextFormField(
                            controller: rutController,
                            keyboardType: TextInputType.text,
                            decoration: _inputDecoration(
                              'RUT',
                              '12345678-9',
                              Icons.badge_outlined,
                            ),
                          ),
                          const SizedBox(height: 32),
                          // Comunicación Header
                          const Row(
                            children: [
                              Icon(Icons.contact_mail, color: Colors.grey, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Comunicación',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Email field
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: _inputDecoration(
                              'Correo electrónico',
                              'tu@correo.com',
                              Icons.email_outlined,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Teléfono field
                          TextFormField(
                            controller: telefonoController,
                            keyboardType: TextInputType.phone,
                            decoration: _inputDecoration(
                              'Teléfono',
                              '+56 9 1234 5678',
                              Icons.phone_outlined,
                            ),
                          ),
                          const SizedBox(height: 32),
                          // Seguridad Header
                          const Row(
                            children: [
                              Icon(Icons.security, color: Colors.grey, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Seguridad',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Password field
                          TextFormField(
                            controller: passwordController,
                            obscureText: !isPasswordVisible,
                            decoration: _inputDecoration(
                              'Contraseña',
                              '••••••••',
                              Icons.lock_outline,
                              suffixIcon: IconButton(
                                onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
                                icon: Icon(isPasswordVisible ? Icons.visibility_off : Icons.visibility, size: 20),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Confirm Password field
                          TextFormField(
                            controller: confirmPasswordController,
                            obscureText: !isConfirmPasswordVisible,
                            decoration: _inputDecoration(
                              'Confirmar Contraseña',
                              '••••••••',
                              Icons.lock_outline,
                              suffixIcon: IconButton(
                                onPressed: () => setState(() => isConfirmPasswordVisible = !isConfirmPasswordVisible),
                                icon: Icon(isConfirmPasswordVisible ? Icons.visibility_off : Icons.visibility, size: 20),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Accept terms
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: acceptTerms,
                                onChanged: (value) => setState(() => acceptTerms = value ?? false),
                              ),
                              const Expanded(
                                child: Text(
                                  'Acepto los términos y condiciones de uso',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          // Register button
                          ElevatedButton(
                            onPressed: isLoading || !acceptTerms ? null : _handleRegister,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : const Text('Registrarse', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          ),
                          const SizedBox(height: 32),
                          // Divider
                          const Row(
                            children: [
                              Expanded(child: Divider()),
                              Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('o')),
                              Expanded(child: Divider()),
                            ],
                          ),
                          const SizedBox(height: 32),
                          // Login text
                          Center(
                            child: InteractiveLink(
                              text: '¿Ya tienes una cuenta? Inicia Sesión',
                              onTap: () => Get.back(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, String hint, IconData icon, {Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, size: 20),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFFF7FAFC),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF4299E1), width: 2),
      ),
    );
  }

  Future<void> _handleRegister() async {
    // Validaciones básicas
    if (nombreController.text.isEmpty ||
        apellidoController.text.isEmpty ||
        rutController.text.isEmpty ||
        emailController.text.isEmpty ||
        telefonoController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Todos los campos son obligatorios',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Las contraseñas no coinciden',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
      );
      return;
    }

    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    
    Get.snackbar(
      'Éxito',
      'Registro completado exitosamente',
      backgroundColor: Colors.green.shade100,
      colorText: Colors.green.shade800,
    );
    
    // Simular navegación de vuelta al login después del registro exitoso
    await Future.delayed(const Duration(seconds: 1));
    Get.back();
    
    setState(() => isLoading = false);
  }
}

class _LeftPanelContent extends StatelessWidget {
  const _LeftPanelContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/gestasocia_icon.png',
              width: 75,
              height: 75,
            ),
            const SizedBox(width: 16),
            const Text('GestAsocia', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Sistema de Gestión de Asociados', style: TextStyle(fontSize: 18, color: Colors.white70)),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: const Column(
            children: [
              _FeatureItem(icon: Icons.person_add_outlined, text: 'Registro rápido y seguro'),
              SizedBox(height: 16),
              _FeatureItem(icon: Icons.security, text: 'Protección de datos garantizada'),
              SizedBox(height: 16),
              _FeatureItem(icon: Icons.verified_user, text: 'Verificación automática'),
            ],
          ),
        ),
      ],
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryColor, size: 20),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: const TextStyle(color: Colors.white70))),
      ],
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppTheme.primaryColor.withOpacity(0.05)..style = PaintingStyle.fill;
    final path = Path();
    
    for (int i = 0; i < 3; i++) {
      final startY = size.height * (0.2 + i * 0.3);
      path.moveTo(0, startY);
      for (double x = 0; x <= size.width; x += 10) {
        final y = startY + 100 * sin((x / size.width * 2 * pi) + (i * pi / 2));
        path.lineTo(x, y);
      }
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();
      canvas.drawPath(path, paint);
      path.reset();
    }

    final circlePaint = Paint()..color = AppTheme.primaryColor.withOpacity(0.03)..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.2), 150, circlePaint);
    canvas.drawCircle(Offset(size.width * 0.9, size.height * 0.8), 200, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}