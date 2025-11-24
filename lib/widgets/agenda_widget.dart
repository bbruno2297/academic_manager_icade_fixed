import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/evaluation_providers.dart';
import '../providers/subject_providers.dart';
import '../widgets/evaluation_card_widget.dart';

class AgendaWidget extends ConsumerWidget {
  const AgendaWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final proximasEvaluationsAsync = ref.watch(proximasEvaluationsProvider);
    final subjectsAsync = ref.watch(allSubjectsProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 24),
              const SizedBox(width: 8),
              Text(
                'Proximas Evaluaciones',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          proximasEvaluationsAsync.when(
            data: (proximasEvaluations) {
              if (proximasEvaluations.isEmpty) {
                return Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            size: 48,
                            color: Colors.green.shade300,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No hay evaluaciones próximas',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return subjectsAsync.when(
                data: (subjects) {
                  return Column(
                    children: proximasEvaluations.map((evaluation) {
                      final subject = subjects.firstWhere(
                        (s) => s.id == evaluation.subjectId,
                        orElse: () => subjects.first,
                      );
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: EvaluationCardWidget(
                          evaluation: evaluation,
                          subject: subject,
                        ),
                      );
                    }).toList(),
                  );
                },
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (error, stack) => Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Error: $error'),
                  ),
                ),
              );
            },
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (error, stack) => Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Error al cargar evaluaciones: $error'),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: TextButton.icon(
              onPressed: () {
                // TODO: Navigate to calendar screen in Phase 2
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text('Calendario completo - Disponible en Phase 2'),
                  ),
                );
              },
              icon: const Icon(Icons.calendar_month),
              label: const Text('Ver calendario completo'),
            ),
          ),
        ],
      ),
    );
  }
}
