import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/evaluation.dart';
import '../models/subject.dart';
import '../providers/evaluation_providers.dart';
import '../providers/subject_providers.dart';
import '../providers/academic_year_providers.dart';
import '../utils/form_validators.dart';

class AddEvaluationScreen extends ConsumerStatefulWidget {
  final int? preselectedSubjectId;

  const AddEvaluationScreen({super.key, this.preselectedSubjectId});

  @override
  ConsumerState<AddEvaluationScreen> createState() =>
      _AddEvaluationScreenState();
}

class _AddEvaluationScreenState extends ConsumerState<AddEvaluationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();

  Subject? _selectedSubject;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  TipoEvaluacion _selectedTipo = TipoEvaluacion.parcial;

  @override
  void dispose() {
    _tituloController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 730)),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _saveEvaluation() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedSubject == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, selecciona una asignatura'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Combine date and time
    final fechaFinal = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    final evaluation = Evaluation()
      ..subjectId = _selectedSubject!.id
      ..titulo = _tituloController.text.trim()
      ..fecha = fechaFinal
      ..tipo = _selectedTipo
      ..estado = EstadoEvaluacion.pendiente
      ..notaInformativa = 0.0;

    try {
      await ref.read(evaluationRepositoryProvider).create(evaluation);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Evaluación "${evaluation.titulo}" creada correctamente'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al crear evaluación: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentYearAsync = ref.watch(currentAcademicYearProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Evaluación'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: currentYearAsync.when(
        data: (currentYear) {
          if (currentYear == null) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  'No hay un año académico activo. Por favor, crea uno primero.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            );
          }

          final subjectsAsync = ref.watch(allSubjectsProvider);

          return subjectsAsync.when(
            data: (allSubjects) {
              final subjects = allSubjects
                  .where((s) => s.academicYearId == currentYear.id)
                  .toList();

              if (subjects.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Text(
                      'No hay asignaturas en el año académico actual. Por favor, añade asignaturas primero.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              }

              // Set preselected subject if provided
              if (widget.preselectedSubjectId != null &&
                  _selectedSubject == null) {
                _selectedSubject = subjects.firstWhere(
                  (s) => s.id == widget.preselectedSubjectId,
                  orElse: () => subjects.first,
                );
              }
              _selectedSubject ??= subjects.first;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Asignatura
                      DropdownButtonFormField<Subject>(
                        initialValue: _selectedSubject,
                        decoration: const InputDecoration(
                          labelText: 'Asignatura',
                          prefixIcon: Icon(Icons.school),
                          border: OutlineInputBorder(),
                        ),
                        items: subjects.map((subject) {
                          return DropdownMenuItem(
                            value: subject,
                            child: Text(subject.nombre),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedSubject = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // Título
                      TextFormField(
                        controller: _tituloController,
                        decoration: const InputDecoration(
                          labelText: 'Título de la evaluación',
                          prefixIcon: Icon(Icons.assignment),
                          border: OutlineInputBorder(),
                          hintText: 'Ej: Examen Parcial Tema 1-3',
                        ),
                        validator: FormValidators.validateRequired,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      const SizedBox(height: 20),

                      // Tipo
                      DropdownButtonFormField<TipoEvaluacion>(
                        initialValue: _selectedTipo,
                        decoration: const InputDecoration(
                          labelText: 'Tipo de evaluación',
                          prefixIcon: Icon(Icons.category),
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: TipoEvaluacion.parcial,
                            child: Text('Parcial'),
                          ),
                          DropdownMenuItem(
                            value: TipoEvaluacion.final_,
                            child: Text('Final'),
                          ),
                          DropdownMenuItem(
                            value: TipoEvaluacion.practica,
                            child: Text('Práctica/Entrega'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedTipo = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 20),

                      // Fecha
                      InkWell(
                        onTap: _selectDate,
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Fecha',
                            prefixIcon: Icon(Icons.calendar_today),
                            border: OutlineInputBorder(),
                          ),
                          child: Text(
                              DateFormat('dd/MM/yyyy').format(_selectedDate)),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Hora
                      InkWell(
                        onTap: _selectTime,
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Hora',
                            prefixIcon: Icon(Icons.access_time),
                            border: OutlineInputBorder(),
                          ),
                          child: Text(_selectedTime.format(context)),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Botón Guardar
                      ElevatedButton.icon(
                        onPressed: _saveEvaluation,
                        icon: const Icon(Icons.save),
                        label: const Text('Guardar Evaluación'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
