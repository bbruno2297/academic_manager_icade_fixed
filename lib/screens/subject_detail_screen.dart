import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/subject.dart';
import '../providers/subject_providers.dart';
import '../providers/evaluation_providers.dart';
import 'edit_subject_screen.dart';
import 'add_evaluation_screen.dart';
import '../widgets/evaluation_card_widget.dart';

class SubjectDetailScreen extends ConsumerWidget {
  final Subject subject;

  const SubjectDetailScreen({super.key, required this.subject});

  Future<void> _deleteSubject(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content:
            Text('¿Estás seguro de que quieres eliminar "${subject.nombre}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        await ref.read(subjectRepositoryProvider).delete(subject.id);
        if (context.mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Asignatura eliminada correctamente'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al eliminar asignatura: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Color _getCarreraColor() {
    switch (subject.carrera) {
      case Carrera.derecho:
        return Colors.blue.shade700;
      case Carrera.ade:
        return Colors.green.shade700;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final evaluationsAsync =
        ref.watch(evaluationsBySubjectProvider(subject.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(subject.nombre),
        backgroundColor: _getCarreraColor(),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditSubjectScreen(subject: subject),
                ),
              );
              // Refresh is automatic via Riverpod stream
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteSubject(context, ref),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subject Info Card
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.school, size: 32, color: _getCarreraColor()),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                subject.nombre,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                subject.carrera == Carrera.derecho
                                    ? 'Derecho'
                                    : 'ADE',
                                style: TextStyle(
                                  color: _getCarreraColor(),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    _buildInfoRow(
                        'Semestre',
                        subject.semestre == Semestre.primero
                            ? '1º Semestre'
                            : '2º Semestre',
                        Icons.calendar_today),
                    const SizedBox(height: 12),
                    _buildInfoRow(
                        'ECTS', '${subject.ects} créditos', Icons.numbers),
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      'Nota Final',
                      subject.notaFinal > 0
                          ? subject.notaFinal.toStringAsFixed(2)
                          : 'Sin nota',
                      Icons.grade,
                      valueColor:
                          subject.notaFinal >= 5 ? Colors.green : Colors.grey,
                    ),
                  ],
                ),
              ),
            ),

            // Evaluations Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Text(
                    'Evaluaciones',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddEvaluationScreen(
                            preselectedSubjectId: subject.id,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            evaluationsAsync.when(
              data: (evaluations) {
                if (evaluations.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.assignment_outlined,
                              size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'No hay evaluaciones programadas',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: evaluations.length,
                  itemBuilder: (context, index) {
                    final evaluation = evaluations[index];
                    return EvaluationCardWidget(
                      evaluation: evaluation,
                      subject: subject,
                    );
                  },
                );
              },
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (error, stack) => Padding(
                padding: const EdgeInsets.all(32),
                child: Text('Error: $error'),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon,
      {Color? valueColor}) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade600),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        Text(
          value,
          style: TextStyle(color: valueColor ?? Colors.black87),
        ),
      ],
    );
  }
}
