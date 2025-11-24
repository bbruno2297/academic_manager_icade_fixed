import 'package:flutter/material.dart';

class SidebarWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const SidebarWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 250,
      color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFF003366),
      child: Column(
        children: [
          // Logo Area
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Row(
              children: [
                Icon(
                  Icons.school,
                  color: Colors.white,
                  size: 32,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Academic',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Manager',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white24),
          const SizedBox(height: 16),

          // Menu Items
          _SidebarItem(
            icon: Icons.dashboard,
            label: 'Dashboard',
            isSelected: selectedIndex == 0,
            onTap: () => onItemSelected(0),
          ),
          _SidebarItem(
            icon: Icons.school,
            label: 'Asignaturas',
            isSelected: selectedIndex == 1,
            onTap: () => onItemSelected(1),
          ),
          _SidebarItem(
            icon: Icons.calendar_today,
            label: 'Calendario',
            isSelected: selectedIndex == 2,
            onTap: () => onItemSelected(2),
          ),
          _SidebarItem(
            icon: Icons.bar_chart,
            label: 'Estadísticas',
            isSelected: selectedIndex == 3,
            onTap: () => onItemSelected(3),
          ),
          _SidebarItem(
            icon: Icons.calendar_month,
            label: 'Años Académicos',
            isSelected: selectedIndex == 4,
            onTap: () => onItemSelected(4),
          ),

          const Spacer(),
          const Divider(color: Colors.white24),

          _SidebarItem(
            icon: Icons.settings,
            label: 'Configuración',
            isSelected: selectedIndex == 5,
            onTap: () => onItemSelected(5),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            border: isSelected
                ? const Border(
                    left: BorderSide(color: Colors.white, width: 4),
                  )
                : null,
            color: isSelected ? Colors.white.withValues(alpha: 0.1) : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.white70,
                size: 22,
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white70,
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
