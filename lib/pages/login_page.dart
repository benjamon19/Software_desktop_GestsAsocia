import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_theme.dart';
import '../utils/app_routes.dart';
import '../widgets/interactive_link.dart';
import '../widgets/shared_widgets.dart';

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
            // Panel izquierdo usando widget reutilizable
            LeftPanel(
              title: 'GestAsocia',
              subtitle: 'Sistema de Gestión de Asociados',
              features: const [
                FeatureItem(icon: Icons.people_outline, text: 'Gestión completa de asociados'),
                FeatureItem(icon: Icons.family_restroom, text: 'Control de cargas familiares'),
                FeatureItem(icon: Icons.calendar_today, text: 'Sistema de reservas médicas'),
              ],
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
                          // Email/RUT field
                          AppTextField(
                            controller: emailController,
                            label: 'RUT o Correo electrónico',
                            hint: 'Ej: 12345678-9 o ejemplo@correo.com',
                            icon: Icons.person_outline,
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 24),
                          // Password field
                          AppTextField(
                            controller: passwordController,
                            label: 'Contraseña',
                            hint: '••••••••',
                            icon: Icons.lock_outline,
                            obscureText: !isPasswordVisible,
                            suffixIcon: IconButton(
                              onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
                              icon: Icon(isPasswordVisible ? Icons.visibility_off : Icons.visibility, size: 20),
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
                          Center(
                            child: InteractiveLink(
                              text: '¿No tienes una cuenta? Regístrate',
                              onTap: () => Get.toNamed(AppRoutes.register),
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