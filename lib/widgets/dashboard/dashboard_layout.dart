import 'package:flutter/material.dart';
import 'sidebar_widget.dart';

class DashboardLayout extends StatelessWidget {
  final Widget child;
  final int selectedIndex;
  final Function(int) onItemSelected;
  final String title;
  final List<Widget>? actions;

  const DashboardLayout({
    super.key,
    required this.child,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA);

    return Scaffold(
      backgroundColor: bgColor,
      body: Row(
        children: [
          // Sidebar
          SidebarWidget(
            selectedIndex: selectedIndex,
            onItemSelected: onItemSelected,
          ),

          // Main Content
          Expanded(
            child: Column(
              children: [
                // Header - MÁS COMPACTO
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12), // Reduced
                  decoration: BoxDecoration(
                    color: bgColor,
                    border: Border(
                      bottom: BorderSide(
                        color: isDark
                            ? const Color(0xFF404040)
                            : const Color(0xFFE0E0E0),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16, // Reduced from 24
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurface,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Hola, Juan 👋',
                            style: TextStyle(
                              fontSize: 12, // Reduced from 14
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      if (actions != null) ...actions!,
                      const SizedBox(width: 12),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius:
                              BorderRadius.circular(4), // Less rounded
                        ),
                        child: const Center(
                          child: Text(
                            'J',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Content Body
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16), // Reduced from 32
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
