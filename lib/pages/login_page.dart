import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/app_theme.dart';
import '../../utils/app_routes.dart';
import '../../widgets/interactive_link.dart';
import '../../widgets/shared_widgets.dart';
import '../../widgets/theme_toggle_button.dart';

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

  final AuthController authController = Get.find<AuthController>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: AppTheme.backgroundColor,
            child: Row(
              children: [
                // Panel izquierdo (siempre oscuro)
                LeftPanel(
                  title: 'GestAsocia',
                  subtitle: 'Sistema de Gestión de Asociados',
                  features: const [
                    FeatureItem(icon: Icons.people_outline, text: 'Gestión completa de asociados'),
                    FeatureItem(icon: Icons.family_restroom, text: 'Control de cargas familiares'),
                    FeatureItem(icon: Icons.calendar_today, text: 'Sistema de reservas médicas'),
                  ],
                ),
                // Panel derecho (adaptativo)
                Expanded(
                  flex: 4,
                  child: Container(
                    color: AppTheme.getSurfaceColor(context),
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
                              Text('Bienvenido', style: AppTheme.getHeadingMedium(context)),
                              const SizedBox(height: 8),
                              Text('Ingresa a tu cuenta para continuar', style: AppTheme.getBodyMedium(context)),
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
                                  icon: Icon(
                                    isPasswordVisible ? Icons.visibility_off : Icons.visibility, 
                                    size: 20,
                                    color: AppTheme.getTextSecondary(context),
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
                                  Text('Recordarme', style: AppTheme.getBodyMedium(context)),
                                ],
                              ),
                              const SizedBox(height: 32),
                              // Login button
                              Obx(() => ElevatedButton(
                                onPressed: authController.isLoading.value ? null : _handleLogin,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primaryColor,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: authController.isLoading.value
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                  : const Text('Iniciar Sesión', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                              )),
                              const SizedBox(height: 32),
                              // Divider
                              Row(
                                children: [
                                  Expanded(child: Divider(color: AppTheme.getBorderLight(context))),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16), 
                                    child: Text('o', style: AppTheme.getBodyMedium(context)),
                                  ),
                                  Expanded(child: Divider(color: AppTheme.getBorderLight(context))),
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
          // Botón de cambio de tema
          const ThemeToggleButton(),
        ],
      ),
    );
  }

  Future<void> _handleLogin() async {
    String emailOrRut = emailController.text.trim();
    String password = passwordController.text;

    // Validaciones básicas
    if (emailOrRut.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Completa todos los campos');
      return;
    }

    // PASAR EL VALOR DE rememberMe al AuthController
    bool success = await authController.login(emailOrRut, password, rememberMe: rememberMe);

    // Limpiar campos si fue exitoso
    if (success) {
      emailController.clear();
      passwordController.clear();
      setState(() {
        isPasswordVisible = false;
        rememberMe = false;
      });
    }
  }
}