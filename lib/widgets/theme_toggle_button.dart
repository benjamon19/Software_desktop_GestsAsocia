import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Positioned(
      top: 20,
      left: 20,
      child: Obx(() => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: PopupMenuButton<int>(
          icon: Icon(
            themeController.themeIcon,
            color: Theme.of(context).colorScheme.onSurface,
            size: 24,
          ),
          tooltip: themeController.themeTooltip,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          offset: const Offset(0, 50),
          itemBuilder: (context) => [
            PopupMenuItem<int>(
              value: ThemeController.systemTheme,
              child: Row(
                children: [
                  Icon(
                    Icons.brightness_auto,
                    color: themeController.currentTheme.value == ThemeController.systemTheme
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Automático',
                    style: TextStyle(
                      color: themeController.currentTheme.value == ThemeController.systemTheme
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface,
                      fontWeight: themeController.currentTheme.value == ThemeController.systemTheme
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem<int>(
              value: ThemeController.lightTheme,
              child: Row(
                children: [
                  Icon(
                    Icons.light_mode,
                    color: themeController.currentTheme.value == ThemeController.lightTheme
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Modo claro',
                    style: TextStyle(
                      color: themeController.currentTheme.value == ThemeController.lightTheme
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface,
                      fontWeight: themeController.currentTheme.value == ThemeController.lightTheme
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem<int>(
              value: ThemeController.darkTheme,
              child: Row(
                children: [
                  Icon(
                    Icons.dark_mode,
                    color: themeController.currentTheme.value == ThemeController.darkTheme
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Modo oscuro',
                    style: TextStyle(
                      color: themeController.currentTheme.value == ThemeController.darkTheme
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface,
                      fontWeight: themeController.currentTheme.value == ThemeController.darkTheme
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            themeController.changeTheme(value);
          },
        ),
      )),
    );
  }
}