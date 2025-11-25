import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/subject_providers.dart';

/// Widget compacto que muestra resumen estadístico
/// NO es protagonista, solo info secundaria con link a vista completa
class CompactStatsWidget extends ConsumerWidget {
  const CompactStatsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allSubjectsAsync = ref.watch(allSubjectsProvider);

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
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // TODO: Navigate to full stats view
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: allSubjectsAsync.when(
            data: (subjects) {
              final subjectsWithGrade =
                  subjects.where((s) => s.notaFinal > 0).toList();

              final averageGrade = subjectsWithGrade.isEmpty
                  ? 0.0
                  : subjectsWithGrade.fold(0.0, (sum, s) => sum + s.notaFinal) /
                      subjectsWithGrade.length;

              final totalECTS = subjects.fold(
                  0.0, (sum, s) => sum + (s.notaFinal >= 5 ? s.ects : 0));

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.bar_chart,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Resumen',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatItem(
                        label: 'Media',
                        value: averageGrade.toStringAsFixed(1),
                        color: _getGradeColor(averageGrade),
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        color: Theme.of(context)
                            .colorScheme
                            .outlineVariant
                            .withValues(alpha: 0.3),
                      ),
                      _StatItem(
                        label: 'ECTS',
                        value: '${totalECTS.toStringAsFixed(0)}/240',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: TextButton.icon(
                      onPressed: () {
                        // TODO: Navigate to full stats
                      },
                      icon: const Icon(Icons.arrow_forward, size: 14),
                      label: const Text(
                        'Ver estadísticas completas',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (_, __) => const Center(
              child: Text('Error'),
            ),
          ),
        ),
      ),
    );
  }

  Color _getGradeColor(double grade) {
    if (grade < 5) return Colors.red;
    if (grade < 7) return Colors.orange;
    if (grade < 9) return Colors.blue;
    return Colors.green;
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
