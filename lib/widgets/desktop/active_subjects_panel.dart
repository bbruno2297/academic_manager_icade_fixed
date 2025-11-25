import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/subject_providers.dart';
import '../../models/subject.dart';

/// Panel que muestra las asignaturas activas del año académico actual
/// Vista rápida y compacta para el dashboard
class ActiveSubjectsPanel extends ConsumerWidget {
  const ActiveSubjectsPanel({super.key});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.school,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Mis Asignaturas',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: allSubjectsAsync.when(
              data: (subjects) {
                if (subjects.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'No hay asignaturas\nregistradas',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }

                // Mostrar solo las primeras 6-8 asignaturas
                final displaySubjects = subjects.take(8).toList();

                return ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: displaySubjects.length + 1, // +1 for "Ver todas"
                  separatorBuilder: (_, __) => const SizedBox(height: 4),
                  itemBuilder: (context, index) {
                    if (index == displaySubjects.length) {
                      return TextButton.icon(
                        onPressed: () {
                          // TODO: Navigate to subjects view
                        },
                        icon: const Icon(Icons.arrow_forward, size: 16),
                        label: const Text('Ver todas...'),
                      );
                    }

                    final subject = displaySubjects[index];
                    return _SubjectListItem(subject: subject);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const Center(
                child: Text('Error cargando asignaturas'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubjectListItem extends StatelessWidget {
  final Subject subject;

  const _SubjectListItem({required this.subject});

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();
    final hasGrade = subject.notaFinal > 0;

    return InkWell(
      onTap: () {
        // TODO: Show subject details in inspector panel
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: statusColor.withValues(alpha: 0.05),
          border: Border.all(
            color: statusColor.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Status indicator
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),

            // Subject name
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject.nombre,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subject.carrera.toString().split('.').last.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            // Grade and ECTS
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (hasGrade)
                  Text(
                    subject.notaFinal.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  )
                else
                  Text(
                    'Pend.',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                Text(
                  '${subject.ects} ECTS',
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor() {
    if (subject.notaFinal == 0) {
      return Colors.grey;
    } else if (subject.notaFinal < 5) {
      return Colors.red;
    } else if (subject.notaFinal < 7) {
      return Colors.orange;
    } else if (subject.notaFinal < 9) {
      return Colors.blue;
    } else {
      return Colors.green;
    }
  }
}
