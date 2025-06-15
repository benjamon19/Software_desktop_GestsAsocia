import 'package:get/get.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';

  static List<GetPage> routes = [
    GetPage(
      name: login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: register,
      page: () => const RegisterPage(),
    ),
  ];
}