import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_theme.dart';
import '../utils/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _fadeController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _navigateToLogin();
  }

  void _setupAnimations() {
    // Animación de rotación
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));

    // Animación de fade in
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    // Iniciar animaciones
    _fadeController.forward();
    _rotationController.repeat();
  }

  void _navigateToLogin() {
    // Navegar al login después de 3 segundos
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Get.offAllNamed(AppRoutes.login);
      }
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.primaryColor,
              AppTheme.secondaryColor,
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo con animación
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Círculo giratorio exterior
                    RotationTransition(
                      turns: _rotationAnimation,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: const SizedBox(),
                      ),
                    ),
                    // Círculo giratorio medio
                    RotationTransition(
                      turns: Tween<double>(begin: 1, end: 0)
                          .animate(_rotationController),
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.5),
                            width: 1.5,
                          ),
                        ),
                        child: const SizedBox(),
                      ),
                    ),
                    // Logo central
                    Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.people_outline,
                        size: 35,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Nombre de la app
                const Text(
                  'GestAsocia',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                // Subtítulo
                Text(
                  'Sistema de Gestión de Asociados',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 60),
                // Indicador de carga
                SizedBox(
                  width: 200,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    minHeight: 3,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Cargando...',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}