import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/subject.dart';
import '../providers/subject_providers.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allSubjectsAsync = ref.watch(allSubjectsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadísticas'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: allSubjectsAsync.when(
        data: (subjects) {
          if (subjects.isEmpty) {
            return const Center(
              child: Text('No hay asignaturas para mostrar estadísticas'),
            );
          }

          // Filtrar asignaturas con nota
          final subjectsWithGrade =
              subjects.where((s) => s.notaFinal > 0).toList();

          // Calcular métricas
          final totalECTS = subjects.fold(
              0.0, (sum, s) => sum + (s.notaFinal >= 5 ? s.ects : 0));
          final averageGrade = subjectsWithGrade.isEmpty
              ? 0.0
              : subjectsWithGrade.fold(0.0, (sum, s) => sum + s.notaFinal) /
                  subjectsWithGrade.length;

          // Datos para gráfico de pastel (ECTS por carrera)
          final ectsDerecho = subjects
              .where((s) => s.carrera == Carrera.derecho && s.notaFinal >= 5)
              .fold(0.0, (sum, s) => sum + s.ects);
          final ectsADE = subjects
              .where((s) => s.carrera == Carrera.ade && s.notaFinal >= 5)
              .fold(0.0, (sum, s) => sum + s.ects);

          // Datos para gráfico de barras (Distribución de notas)
          int aprobados = 0;
          int notables = 0;
          int sobresalientes = 0;
          int suspensos = 0;

          for (var s in subjectsWithGrade) {
            if (s.notaFinal < 5) {
              suspensos++;
            } else if (s.notaFinal < 7) {
              aprobados++;
            } else if (s.notaFinal < 9) {
              notables++;
            } else {
              sobresalientes++;
            }
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tarjetas de Resumen
                Row(
                  children: [
                    Expanded(
                      child: _SummaryCard(
                        title: 'Media Global',
                        value: averageGrade.toStringAsFixed(2),
                        icon: Icons.grade,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _SummaryCard(
                        title: 'ECTS Superados',
                        value: totalECTS.toStringAsFixed(1),
                        icon: Icons.check_circle,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Gráfico de Pastel (ECTS por Carrera)
                const Text(
                  'Distribución de Créditos (ECTS)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          value: ectsDerecho,
                          title: 'Derecho\n${ectsDerecho.toStringAsFixed(0)}',
                          color: Colors.red.shade400,
                          radius: 60,
                          titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          value: ectsADE,
                          title: 'ADE\n${ectsADE.toStringAsFixed(0)}',
                          color: Colors.blue.shade400,
                          radius: 60,
                          titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Mejor y Peor Asignatura
                if (subjectsWithGrade.isNotEmpty) ...[
                  const Text(
                    'Destacados',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _HighlightCard(
                          title: 'Mejor Asignatura',
                          subject: subjectsWithGrade.reduce(
                              (a, b) => a.notaFinal > b.notaFinal ? a : b),
                          color: Colors.green,
                          icon: Icons.thumb_up,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _HighlightCard(
                          title: 'A mejorar',
                          subject: subjectsWithGrade.reduce(
                              (a, b) => a.notaFinal < b.notaFinal ? a : b),
                          color: Colors.orange,
                          icon: Icons.trending_up,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],

                // Gráfico de Barras (Notas)
                const Text(
                  'Distribución de Notas',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: (subjectsWithGrade.length + 1).toDouble(),
                      barTouchData: const BarTouchData(enabled: false),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              switch (value.toInt()) {
                                case 0:
                                  return const Text('Susp.',
                                      style: TextStyle(fontSize: 10));
                                case 1:
                                  return const Text('Apro.',
                                      style: TextStyle(fontSize: 10));
                                case 2:
                                  return const Text('Not.',
                                      style: TextStyle(fontSize: 10));
                                case 3:
                                  return const Text('Sob.',
                                      style: TextStyle(fontSize: 10));
                                default:
                                  return const Text('');
                              }
                            },
                          ),
                        ),
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(
                              toY: suspensos.toDouble(),
                              color: Colors.red,
                              width: 16,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(
                              toY: aprobados.toDouble(),
                              color: Colors.orange,
                              width: 16,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barRods: [
                            BarChartRodData(
                              toY: notables.toDouble(),
                              color: Colors.blue,
                              width: 16,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 3,
                          barRods: [
                            BarChartRodData(
                              toY: sobresalientes.toDouble(),
                              color: Colors.green,
                              width: 16,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _HighlightCard extends StatelessWidget {
  final String title;
  final Subject subject;
  final Color color;
  final IconData icon;

  const _HighlightCard({
    required this.title,
    required this.subject,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              subject.nombre,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              'Nota: ${subject.notaFinal}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
