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
      width: 230, // un poco más compacto
      decoration: BoxDecoration(
        color: AppTheme.getSurfaceColor(context),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark 
                ? Colors.black.withValues(alpha: 0.25)
                : const Color(0x14000000),
            blurRadius: 8,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Logo
          Container(
            padding: const EdgeInsets.all(20), 
            child: Row(
              children: [
                Image.asset(
                  'assets/images/gestasocia_icon.png',
                  width: 36,
                  height: 36,
                ),
                const SizedBox(width: 10),
                Text(
                  'GestAsocia',
                  style: TextStyle(
                    color: AppTheme.getTextPrimary(context), 
                    fontSize: 20, // un poco más chico
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppTheme.getBorderLight(context)), 
                     
          // Menu Items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: DashboardData.menuItems.length,
              itemBuilder: (context, index) {
                final item = DashboardData.menuItems[index];
                final isSelected = selectedIndex == index;
                                 
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: isSelected
                         ? AppTheme.primaryColor.withValues(alpha: 0.1)
                         : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                    leading: Icon(
                      item['icon'],
                      color: isSelected
                           ? AppTheme.primaryColor
                          : AppTheme.getTextSecondary(context),
                      size: 20, // un poco más pequeño
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
                        fontSize: 14, // levemente más chico
                      ),
                    ),
                    onTap: () => onItemSelected(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
