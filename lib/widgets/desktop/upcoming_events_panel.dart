import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../providers/evaluation_providers.dart';
import '../../models/evaluation.dart';

/// Panel de próximos eventos - ESTILO DESKTOP
/// Diseño plano, denso, profesional
class UpcomingEventsPanel extends ConsumerWidget {
  const UpcomingEventsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final evaluationsAsync = ref.watch(allEvaluationsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF2C2C2C) : Colors.white;
    final borderColor =
        isDark ? const Color(0xFF404040) : const Color(0xFFE0E0E0);
    final headerBg = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F7FA);

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header compacto
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: headerBg,
              border: Border(bottom: BorderSide(color: borderColor, width: 1)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.event_outlined,
                  color: Theme.of(context).colorScheme.primary,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Próximos Eventos',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: evaluationsAsync.when(
              data: (evaluations) {
                final now = DateTime.now();
                final upcomingEvals = evaluations
                    .where((e) => e.fecha.isAfter(now))
                    .toList()
                  ..sort((a, b) => a.fecha.compareTo(b.fecha));

                if (upcomingEvals.isEmpty) {
                  return Center(
                    child: Text(
                      'No hay eventos próximos',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                  );
                }

                final displayEvals = upcomingEvals.take(7).toList();

                return ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: displayEvals.length,
                  separatorBuilder: (_, __) => Divider(
                    height: 1,
                    color: borderColor,
                    thickness: 1,
                  ),
                  itemBuilder: (context, index) {
                    final eval = displayEvals[index];
                    return _EventListItem(evaluation: eval, isDark: isDark);
                  },
                );
              },
              loading: () => const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              error: (_, __) => Center(
                child: Text(
                  'Error cargando eventos',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EventListItem extends StatelessWidget {
  final Evaluation evaluation;
  final bool isDark;

  const _EventListItem({required this.evaluation, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final daysUntil = evaluation.fecha.difference(now).inDays;
    final typeColor = _getTypeColor();
    final typeIcon = _getTypeIcon();

    return InkWell(
      onTap: () {
        // TODO: Show event details
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          children: [
            // Date box - más compacto
            Container(
              width: 40,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: typeColor.withValues(alpha: isDark ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                  color: typeColor.withValues(alpha: isDark ? 0.5 : 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    DateFormat('d').format(evaluation.fecha),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: typeColor,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    DateFormat('MMM', 'es')
                        .format(evaluation.fecha)
                        .toUpperCase(),
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                      color: typeColor,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),

            // Event details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(typeIcon, size: 12, color: typeColor),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          evaluation.titulo,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                            height: 1.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _formatDaysUntil(daysUntil),
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor() {
    switch (evaluation.tipo) {
      case TipoEvaluacion.final_:
        return Colors.red;
      case TipoEvaluacion.parcial:
        return Colors.orange;
      case TipoEvaluacion.practica:
        return Colors.blue;
    }
  }

  IconData _getTypeIcon() {
    switch (evaluation.tipo) {
      case TipoEvaluacion.final_:
        return Icons.assignment_outlined;
      case TipoEvaluacion.parcial:
        return Icons.quiz_outlined;
      case TipoEvaluacion.practica:
        return Icons.science_outlined;
    }
  }

  String _formatDaysUntil(int days) {
    if (days == 0) return 'Hoy';
    if (days == 1) return 'Mañana';
    if (days < 7) return 'En $days días';
    final weeks = (days / 7).floor();
    if (weeks == 1) return 'En 1 semana';
    return 'En $weeks semanas';
  }
}
