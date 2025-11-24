import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/academic_year.dart';
import '../providers/academic_year_providers.dart';

class AcademicYearsScreen extends ConsumerWidget {
  const AcademicYearsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final academicYearsAsync = ref.watch(allAcademicYearsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Años Académicos'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: academicYearsAsync.when(
        data: (years) {
          if (years.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No hay años académicos',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Añade uno para empezar a crear asignaturas',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: years.length,
            itemBuilder: (context, index) {
              final year = years[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundColor: year.isCurrentYear
                        ? Colors.green.shade100
                        : Colors.grey.shade200,
                    child: Icon(
                      Icons.calendar_month,
                      color: year.isCurrentYear
                          ? Colors.green.shade700
                          : Colors.grey.shade600,
                    ),
                  ),
                  title: Text(
                    year.nombre,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        '${DateFormat('dd/MM/yyyy').format(year.fechaInicio)} - ${DateFormat('dd/MM/yyyy').format(year.fechaFin)}',
                      ),
                      if (year.isCurrentYear)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.green.shade200),
                            ),
                            child: Text(
                              'Año Actual',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) async {
                      if (value == 'set_current') {
                        await ref
                            .read(academicYearRepositoryProvider)
                            .setAsCurrent(year.id);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  '${year.nombre} marcado como año actual'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      } else if (value == 'delete') {
                        _confirmDelete(context, ref, year);
                      }
                    },
                    itemBuilder: (context) => [
                      if (!year.isCurrentYear)
                        const PopupMenuItem(
                          value: 'set_current',
                          child: Row(
                            children: [
                              Icon(Icons.check_circle_outline,
                                  color: Colors.green),
                              SizedBox(width: 8),
                              Text('Marcar como Actual'),
                            ],
                          ),
                        ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Eliminar'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/add-academic-year');
        },
        icon: const Icon(Icons.add),
        label: const Text('Añadir Año'),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, AcademicYear year) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Año Académico'),
        content: Text(
            '¿Estás seguro de que quieres eliminar "${year.nombre}"? Esto podría fallar si tiene asignaturas asociadas.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                await ref.read(academicYearRepositoryProvider).delete(year.id);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Año académico eliminado'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: ${e.toString()}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}
