import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../models/evaluation.dart';
import '../providers/evaluation_providers.dart';
import '../providers/subject_providers.dart';
import '../widgets/evaluation_card_widget.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  final bool isEmbedded;
  const CalendarScreen({super.key, this.isEmbedded = false});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  List<Evaluation> _getEvaluationsForDay(
      DateTime day, List<Evaluation> evaluations) {
    return evaluations.where((evaluation) {
      return isSameDay(evaluation.fecha, day);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final evaluationsAsync = ref.watch(allEvaluationsProvider);

    return widget.isEmbedded
        ? _buildBody(context, evaluationsAsync)
        : Scaffold(
            appBar: AppBar(
              title: const Text('Calendario Académico'),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
            body: _buildBody(context, evaluationsAsync),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add-evaluation');
              },
              child: const Icon(Icons.add),
            ),
          );
  }

  Widget _buildBody(
      BuildContext context, AsyncValue<List<Evaluation>> evaluationsAsync) {
    return evaluationsAsync.when(
      data: (evaluations) {
        final selectedEvaluations = _getEvaluationsForDay(
          _selectedDay ?? _focusedDay,
          evaluations,
        );

        return Column(
          children: [
            TableCalendar<Evaluation>(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              eventLoader: (day) {
                return _getEvaluationsForDay(day, evaluations);
              },
              calendarStyle: CalendarStyle(
                markerDecoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(
                            DateFormat('EEEE, d MMMM', 'es')
                                .format(_selectedDay ?? _focusedDay)
                                .toUpperCase(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${selectedEvaluations.length} eventos',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: selectedEvaluations.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.event_available,
                                    size: 48,
                                    color: Colors.grey.shade300,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No hay evaluaciones para este día',
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              itemCount: selectedEvaluations.length,
                              itemBuilder: (context, index) {
                                final evaluation = selectedEvaluations[index];
                                final subjectAsync = ref.watch(
                                    subjectProvider(evaluation.subjectId));

                                return subjectAsync.when(
                                  data: (subject) {
                                    if (subject == null) {
                                      return const SizedBox.shrink();
                                    }
                                    return EvaluationCardWidget(
                                      evaluation: evaluation,
                                      subject: subject,
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          '/evaluation-detail',
                                          arguments: {
                                            'evaluation': evaluation,
                                            'subject': subject,
                                          },
                                        );
                                      },
                                    );
                                  },
                                  loading: () => const Center(
                                      child: CircularProgressIndicator()),
                                  error: (_, __) => const SizedBox.shrink(),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
