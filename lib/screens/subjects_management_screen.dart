import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/subject.dart';
import '../providers/subject_providers.dart';
import '../widgets/subject_card_widget.dart';

class SubjectsManagementScreen extends ConsumerWidget {
  final bool isEmbedded;
  const SubjectsManagementScreen({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allSubjectsAsync = ref.watch(allSubjectsProvider);

    return isEmbedded
        ? _buildBody(context, allSubjectsAsync)
        : Scaffold(
            appBar: AppBar(
              title: const Text('Asignaturas'),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
            body: _buildBody(context, allSubjectsAsync),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, '/add-subject');
              },
              icon: const Icon(Icons.add),
              label: const Text('Añadir Asignatura'),
            ),
          );
  }

  Widget _buildBody(
      BuildContext context, AsyncValue<List<Subject>> allSubjectsAsync) {
    return allSubjectsAsync.when(
      data: (subjects) {
        if (subjects.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.school_outlined,
                  size: 80,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 16),
                Text(
                  'No hay asignaturas',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Usa el botón + para añadir una asignatura',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          );
        }

        // Group by academic year
        final subjectsByYear = <int, List<Subject>>{};
        for (final subject in subjects) {
          subjectsByYear
              .putIfAbsent(subject.academicYearId, () => [])
              .add(subject);
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: subjectsByYear.length,
          itemBuilder: (context, index) {
            final yearId = subjectsByYear.keys.elementAt(index);
            final yearSubjects = subjectsByYear[yearId]!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 20,
                        color: Colors.grey.shade700,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Año Académico $yearId',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${yearSubjects.length} asignaturas',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ...yearSubjects
                    .map((subject) => SubjectCardWidget(subject: subject)),
                const SizedBox(height: 16),
              ],
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: $error'),
          ],
        ),
      ),
    );
  }
}
