import 'package:get/get.dart';
import '../pages/login_page.dart';

class AppRoutes {
  // Rutas principales
  static const String login = '/login';
  
  // Lista de rutas configuradas para GetX
  static List<GetPage> routes = [
    GetPage(
      name: login,
      page: () => const LoginPage(),
    ),
  ];
}