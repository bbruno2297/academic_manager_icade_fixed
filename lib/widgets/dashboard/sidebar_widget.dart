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
    final bgColor = isDark ? const Color(0xFF1E1E1E) : const Color(0xFF2C3E50);

    return Container(
      width: 220, // Reduced from 250
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          right: BorderSide(
            color: isDark ? const Color(0xFF404040) : const Color(0xFF1A252F),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Logo Area - más compacto
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 16), // Reduced
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isDark
                      ? const Color(0xFF404040)
                      : const Color(0xFF1A252F),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.school,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Academic',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        'Manager',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Menu Items - estilo Windows/VSCode
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 4),
              children: [
                _SidebarItem(
                  icon: Icons.dashboard_outlined,
                  iconSelected: Icons.dashboard,
                  label: 'Dashboard',
                  isSelected: selectedIndex == 0,
                  onTap: () => onItemSelected(0),
                ),
                _SidebarItem(
                  icon: Icons.school_outlined,
                  iconSelected: Icons.school,
                  label: 'Asignaturas',
                  isSelected: selectedIndex == 1,
                  onTap: () => onItemSelected(1),
                ),
                _SidebarItem(
                  icon: Icons.calendar_today_outlined,
                  iconSelected: Icons.calendar_today,
                  label: 'Calendario',
                  isSelected: selectedIndex == 2,
                  onTap: () => onItemSelected(2),
                ),
                _SidebarItem(
                  icon: Icons.bar_chart_outlined,
                  iconSelected: Icons.bar_chart,
                  label: 'Estadísticas',
                  isSelected: selectedIndex == 3,
                  onTap: () => onItemSelected(3),
                ),
                _SidebarItem(
                  icon: Icons.calendar_month_outlined,
                  iconSelected: Icons.calendar_month,
                  label: 'Años Académicos',
                  isSelected: selectedIndex == 4,
                  onTap: () => onItemSelected(4),
                ),
                const SizedBox(height: 8),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
                const SizedBox(height: 8),
                _SidebarItem(
                  icon: Icons.settings_outlined,
                  iconSelected: Icons.settings,
                  label: 'Configuración',
                  isSelected: selectedIndex == 5,
                  onTap: () => onItemSelected(5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatefulWidget {
  final IconData icon;
  final IconData iconSelected;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.iconSelected,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<_SidebarItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isSelected
        ? Colors.white.withValues(alpha: 0.15)
        : _isHovered
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.transparent;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
          padding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 8), // Compact
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(4),
            border: widget.isSelected
                ? Border(
                    left: BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                  )
                : null,
          ),
          child: Row(
            children: [
              Icon(
                widget.isSelected ? widget.iconSelected : widget.icon,
                color: widget.isSelected ? Colors.white : Colors.white70,
                size: 18, // Smaller icons
              ),
              const SizedBox(width: 12),
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.isSelected ? Colors.white : Colors.white70,
                  fontSize: 13, // Smaller text
                  fontWeight:
                      widget.isSelected ? FontWeight.w600 : FontWeight.normal,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
