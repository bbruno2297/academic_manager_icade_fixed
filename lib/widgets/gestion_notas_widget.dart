import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/subject.dart';
import '../providers/subject_providers.dart';

class GestionNotasWidget extends ConsumerWidget {
  const GestionNotasWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectsBySemestre = ref.watch(subjectsBySemestreProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.school, size: 24),
              const SizedBox(width: 8),
              Text(
                'Gestion de Notas',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSemestreSection(
            context,
            ref,
            'Primer Semestre',
            subjectsBySemestre[Semestre.primero] ?? [],
            Colors.blue,
          ),
          const SizedBox(height: 20),
          _buildSemestreSection(
            context,
            ref,
            'Segundo Semestre',
            subjectsBySemestre[Semestre.segundo] ?? [],
            Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildSemestreSection(
    BuildContext context,
    WidgetRef ref,
    String titulo,
    List<Subject> asignaturas,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            titulo,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (asignaturas.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'No hay asignaturas en este semestre',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
          )
        else
          ...asignaturas
              .map((subject) => _buildSubjectCard(context, ref, subject)),
      ],
    );
  }

  Widget _buildSubjectCard(
      BuildContext context, WidgetRef ref, Subject subject) {
    final repository = ref.read(subjectRepositoryProvider);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subject.nombre,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: subject.carrera == Carrera.derecho
                                  ? Colors.blue.shade50
                                  : Colors.green.shade50,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              subject.carrera == Carrera.derecho
                                  ? 'Derecho'
                                  : 'ADE',
                              style: TextStyle(
                                fontSize: 12,
                                color: subject.carrera == Carrera.derecho
                                    ? Colors.blue.shade700
                                    : Colors.green.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${subject.ects} ECTS',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Nota Final:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      hintText: 'Ej: 8.5',
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      suffixIcon: subject.notaFinal > 0
                          ? Icon(
                              Icons.check_circle,
                              color: subject.notaFinal >= 5.0
                                  ? Colors.green
                                  : Colors.red,
                            )
                          : null,
                    ),
                    controller: TextEditingController(
                      text: subject.notaFinal > 0
                          ? subject.notaFinal.toString()
                          : '',
                    ),
                    onSubmitted: (value) async {
                      final nota = double.tryParse(value) ?? 0.0;
                      if (nota >= 0 && nota <= 10) {
                        await repository.updateNotaFinal(subject.id, nota);

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Nota actualizada: ${subject.nombre}',
                              ),
                              duration: const Duration(seconds: 2),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('La nota debe estar entre 0 y 10'),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
