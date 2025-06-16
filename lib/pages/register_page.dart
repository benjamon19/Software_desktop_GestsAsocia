import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../services/auth_helper.dart';
import '../../utils/app_theme.dart';
import '../../widgets/interactive_link.dart';
import '../../widgets/shared_widgets.dart';
import '../../widgets/theme_toggle_button.dart';

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

  final AuthController authController = Get.find<AuthController>();

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
                    FeatureItem(icon: Icons.person_add_outlined, text: 'Registro rápido y seguro'),
                    FeatureItem(icon: Icons.security, text: 'Protección de datos garantizada'),
                    FeatureItem(icon: Icons.verified_user, text: 'Verificación automática'),
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
                              Text('Crear Cuenta', style: AppTheme.getHeadingMedium(context)),
                              const SizedBox(height: 8),
                              Text('Completa los datos para registrarte', style: AppTheme.getBodyMedium(context)),
                              const SizedBox(height: 32),
                              // Información Personal
                              const SectionHeader(icon: Icons.person, title: 'Información Personal'),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: AppTextField(
                                      controller: nombreController,
                                      label: 'Nombre',
                                      hint: 'Tu nombre',
                                      icon: Icons.person_outline,
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: AppTextField(
                                      controller: apellidoController,
                                      label: 'Apellido',
                                      hint: 'Tu apellido',
                                      icon: Icons.person_outline,
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              AppTextField(
                                controller: rutController,
                                label: 'RUT',
                                hint: '12345678-9',
                                icon: Icons.badge_outlined,
                              ),
                              const SizedBox(height: 32),
                              // Comunicación
                              const SectionHeader(icon: Icons.contact_mail, title: 'Comunicación'),
                              const SizedBox(height: 16),
                              AppTextField(
                                controller: emailController,
                                label: 'Correo electrónico',
                                hint: 'tu@correo.com',
                                icon: Icons.email_outlined,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 20),
                              AppTextField(
                                controller: telefonoController,
                                label: 'Teléfono',
                                hint: '9 1234 5678',
                                icon: Icons.phone_outlined,
                                keyboardType: TextInputType.phone,
                              ),
                              const SizedBox(height: 32),
                              // Seguridad
                              const SectionHeader(icon: Icons.security, title: 'Seguridad'),
                              const SizedBox(height: 16),
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
                              const SizedBox(height: 20),
                              AppTextField(
                                controller: confirmPasswordController,
                                label: 'Confirmar Contraseña',
                                hint: '••••••••',
                                icon: Icons.lock_outline,
                                obscureText: !isConfirmPasswordVisible,
                                suffixIcon: IconButton(
                                  onPressed: () => setState(() => isConfirmPasswordVisible = !isConfirmPasswordVisible),
                                  icon: Icon(
                                    isConfirmPasswordVisible ? Icons.visibility_off : Icons.visibility, 
                                    size: 20,
                                    color: AppTheme.getTextSecondary(context),
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
                                  Expanded(
                                    child: Text(
                                      'Acepto los términos y condiciones de uso',
                                      style: AppTheme.getBodyMedium(context),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              // Register button
                              Obx(() => ElevatedButton(
                                onPressed: authController.isLoading.value || !acceptTerms ? null : _handleRegister,
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
                                  : const Text('Registrarse', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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
          // Botón de cambio de tema
          const ThemeToggleButton(),
        ],
      ),
    );
  }

  Future<void> _handleRegister() async {
    // Validar campos usando el helper
    String? error = AuthHelper.validateRegisterFields(
      nombre: nombreController.text.trim(),
      apellido: apellidoController.text.trim(),
      rut: rutController.text.trim(),
      email: emailController.text.trim(),
      telefono: telefonoController.text.trim(),
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
    );

    if (error != null) {
      Get.snackbar('Error', error);
      return;
    }

    // Realizar registro
    bool success = await authController.register(
      email: emailController.text.trim(),
      password: passwordController.text,
      nombre: nombreController.text.trim(),
      apellido: apellidoController.text.trim(),
      telefono: telefonoController.text.trim(),
      rut: rutController.text.trim(),
    );

    // Limpiar campos si fue exitoso
    if (success) {
      _clearFields();
    }
  }

  void _clearFields() {
    nombreController.clear();
    apellidoController.clear();
    rutController.clear();
    emailController.clear();
    telefonoController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    setState(() {
      isPasswordVisible = false;
      isConfirmPasswordVisible = false;
      acceptTerms = false;
    });
  }
}