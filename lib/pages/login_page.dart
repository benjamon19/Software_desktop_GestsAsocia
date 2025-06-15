import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_theme.dart';
import 'dart:math';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  bool isPasswordVisible = false;
  bool rememberMe = false;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                              Text('Bienvenido', style: AppTheme.headingMedium),
                              SizedBox(height: 8),
                              Text('Ingresa a tu cuenta para continuar'),
                            ],
                          ),
                          const SizedBox(height: 32),
                          // Email field
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: _inputDecoration(
                              'Correo electrónico',
                              'ejemplo@correo.com',
                              Icons.email_outlined,
                            ),
                          ),
                          const SizedBox(height: 24),
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
                          const SizedBox(height: 16),
                          // Remember me
                          Row(
                            children: [
                              Checkbox(
                                value: rememberMe,
                                onChanged: (value) => setState(() => rememberMe = value ?? false),
                              ),
                              const Text('Recordarme'),
                            ],
                          ),
                          const SizedBox(height: 32),
                          // Login button
                          ElevatedButton(
                            onPressed: isLoading ? null : _handleLogin,
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
                              : const Text('Iniciar Sesión', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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
                          // Register text
                          const Center(
                            child: Text(
                              '¿No tienes una cuenta? Regístrate',
                              style: TextStyle(color: AppTheme.primaryColor, fontSize: 14),
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

  Future<void> _handleLogin() async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    Get.snackbar(
      'Información',
      'Funcionalidad de login pendiente de implementar',
      backgroundColor: Colors.blue.shade100,
      colorText: Colors.blue.shade800,
    );
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
              _FeatureItem(icon: Icons.people_outline, text: 'Gestión completa de asociados'),
              SizedBox(height: 16),
              _FeatureItem(icon: Icons.family_restroom, text: 'Control de cargas familiares'),
              SizedBox(height: 16),
              _FeatureItem(icon: Icons.calendar_today, text: 'Sistema de reservas médicas'),
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