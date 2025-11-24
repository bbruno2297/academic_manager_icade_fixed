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
    final bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFF5F7FA);

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
                // Header
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                  color: bgColor,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hola, Juan 👋', // TODO: Get real user name
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      if (actions != null) ...actions!,
                      const SizedBox(width: 16),
                      CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: const Text('J',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),

                // Content Body
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
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
