import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/subject_providers.dart';

class StatsOverviewWidget extends ConsumerWidget {
  const StatsOverviewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allSubjectsAsync = ref.watch(allSubjectsProvider);

    return allSubjectsAsync.when(
      data: (subjects) {
        final subjectsWithGrade =
            subjects.where((s) => s.notaFinal > 0).toList();

        final averageGrade = subjectsWithGrade.isEmpty
            ? 0.0
            : subjectsWithGrade.fold(0.0, (sum, s) => sum + s.notaFinal) /
                subjectsWithGrade.length;

        final totalECTS = subjects.fold(
            0.0, (sum, s) => sum + (s.notaFinal >= 5 ? s.ects : 0));

        return Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'Nota Media',
                value: averageGrade.toStringAsFixed(2),
                icon: Icons.grade,
                color: Colors.blue,
                trend: '+0.2 vs last year', // Placeholder logic
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _StatCard(
                title: 'Créditos Superados',
                value: totalECTS.toStringAsFixed(1),
                icon: Icons.check_circle,
                color: Colors.green,
                trend:
                    '${(totalECTS / 240 * 100).toStringAsFixed(1)}% completado',
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: _StatCard(
                title: 'Próximo Examen',
                value: '3 días',
                icon: Icons.event,
                color: Colors.orange,
                trend: 'Derecho Civil II',
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const SizedBox(),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String trend;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.trend,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context)
              .colorScheme
              .outlineVariant
              .withValues(alpha: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                Icon(
                  Icons.more_horiz,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                trend,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
