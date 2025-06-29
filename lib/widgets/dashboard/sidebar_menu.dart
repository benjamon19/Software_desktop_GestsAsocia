import 'package:flutter/material.dart';
import '../../utils/dashboard_data.dart';
import '../../utils/app_theme.dart';

class SidebarMenu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const SidebarMenu({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: AppTheme.getSurfaceColor(context),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark 
                ? Colors.black.withValues(alpha: 0.3)
                : const Color(0x1A000000),
            blurRadius: 10,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Logo
          Container(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/gestasocia_icon.png',
                  width: 42,
                  height: 42,
                ),
                const SizedBox(width: 12),
                Text(
                  'GestAsocia',
                  style: TextStyle(
                    color: AppTheme.getTextPrimary(context), 
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppTheme.getBorderLight(context)), 
                     
          // Menu Items (sin configuración)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: DashboardData.menuItems.length, // Ahora usa todos los items
              itemBuilder: (context, index) {
                final item = DashboardData.menuItems[index];
                final isSelected = selectedIndex == index;
                                 
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  decoration: BoxDecoration(
                    color: isSelected
                         ? AppTheme.primaryColor.withValues(alpha: 0.1)
                         : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: Icon(
                      item['icon'],
                      color: isSelected
                           ? AppTheme.primaryColor
                          : AppTheme.getTextSecondary(context),
                      size: 22,
                    ),
                    title: Text(
                      item['title'],
                      style: TextStyle(
                        color: isSelected
                             ? AppTheme.primaryColor
                            : AppTheme.getTextPrimary(context),
                        fontWeight: isSelected
                             ? FontWeight.w600
                             : FontWeight.normal,
                        fontSize: 15,
                      ),
                    ),
                    onTap: () => onItemSelected(index),
                  ),
                );
              },
            ),
          ),
          
          // Sin configuración al final
        ],
      ),
    );
  }
}