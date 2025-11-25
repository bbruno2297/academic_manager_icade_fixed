import 'package:flutter/material.dart';

/// Panel de acciones rápidas para el dashboard
/// Botones para acciones frecuentes
class QuickActionsPanel extends StatelessWidget {
  const QuickActionsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context)
              .colorScheme
              .outlineVariant
              .withValues(alpha: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.bolt,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Acciones',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _QuickActionButton(
              icon: Icons.add,
              label: 'Asignatura',
              onPressed: () {
                // TODO: Navigate to add subject
              },
            ),
            const SizedBox(height: 8),
            _QuickActionButton(
              icon: Icons.event,
              label: 'Evaluación',
              onPressed: () {
                // TODO: Navigate to add evaluation
              },
            ),
            const SizedBox(height: 8),
            _QuickActionButton(
              icon: Icons.checklist,
              label: 'Tarea',
              onPressed: () {
                // TODO: Add task inline
              },
            ),
            const Spacer(),
            const Divider(),
            const SizedBox(height: 8),
            _QuickActionButton(
              icon: Icons.settings,
              label: 'Configuración',
              onPressed: () {
                // TODO: Navigate to settings
              },
              isSecondary: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isSecondary;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: isSecondary
          ? OutlinedButton.icon(
              onPressed: onPressed,
              icon: Icon(icon, size: 18),
              label: Text(label),
              style: OutlinedButton.styleFrom(
                alignment: Alignment.centerLeft,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            )
          : ElevatedButton.icon(
              onPressed: onPressed,
              icon: Icon(icon, size: 18),
              label: Text(label),
              style: ElevatedButton.styleFrom(
                alignment: Alignment.centerLeft,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
    );
  }
}
