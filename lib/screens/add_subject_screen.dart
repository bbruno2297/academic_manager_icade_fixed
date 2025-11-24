import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/subject.dart';
import '../providers/subject_providers.dart';
import '../providers/academic_year_providers.dart';
import '../utils/form_validators.dart';

class AddSubjectScreen extends ConsumerStatefulWidget {
  const AddSubjectScreen({super.key});

  @override
  ConsumerState<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends ConsumerState<AddSubjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _ectsController = TextEditingController();
  final _notaFinalController = TextEditingController();

  Carrera _selectedCarrera = Carrera.derecho;
  Semestre _selectedSemestre = Semestre.primero;

  @override
  void dispose() {
    _nombreController.dispose();
    _ectsController.dispose();
    _notaFinalController.dispose();
    super.dispose();
  }

  Future<void> _saveSubject() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Get current academic year
    final currentYear = await ref.read(currentAcademicYearProvider.future);
    if (currentYear == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'No hay un año académico activo. Por favor, crea uno primero.'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    final subject = Subject()
      ..nombre = _nombreController.text.trim()
      ..carrera = _selectedCarrera
      ..semestre = _selectedSemestre
      ..ects = double.parse(_ectsController.text)
      ..notaFinal = _notaFinalController.text.isEmpty
          ? 0.0
          : double.parse(_notaFinalController.text)
      ..academicYearId = currentYear.id;

    try {
      await ref.read(subjectRepositoryProvider).create(subject);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Asignatura "${subject.nombre}" creada correctamente'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al crear asignatura: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Asignatura'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Nombre
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de la asignatura',
                  prefixIcon: Icon(Icons.school),
                  border: OutlineInputBorder(),
                ),
                validator: FormValidators.validateRequired,
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 20),

              // Carrera
              DropdownButtonFormField<Carrera>(
                initialValue: _selectedCarrera,
                decoration: const InputDecoration(
                  labelText: 'Carrera',
                  prefixIcon: Icon(Icons.account_balance),
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: Carrera.derecho,
                    child: Text('Derecho'),
                  ),
                  DropdownMenuItem(
                    value: Carrera.ade,
                    child: Text('ADE'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCarrera = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),

              // Semestre
              DropdownButtonFormField<Semestre>(
                initialValue: _selectedSemestre,
                decoration: const InputDecoration(
                  labelText: 'Semestre',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: Semestre.primero,
                    child: Text('1º Semestre'),
                  ),
                  DropdownMenuItem(
                    value: Semestre.segundo,
                    child: Text('2º Semestre'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedSemestre = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),

              // ECTS
              TextFormField(
                controller: _ectsController,
                decoration: const InputDecoration(
                  labelText: 'Créditos ECTS',
                  prefixIcon: Icon(Icons.numbers),
                  border: OutlineInputBorder(),
                  hintText: '6.0',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: FormValidators.validateECTS,
              ),
              const SizedBox(height: 20),

              // Nota Final (opcional)
              TextFormField(
                controller: _notaFinalController,
                decoration: const InputDecoration(
                  labelText: 'Nota Final (opcional)',
                  prefixIcon: Icon(Icons.grade),
                  border: OutlineInputBorder(),
                  hintText: '0.0',
                  helperText: 'Deja vacío si aún no tienes nota',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: FormValidators.validateNota,
              ),
              const SizedBox(height: 30),

              // Botón Guardar
              ElevatedButton.icon(
                onPressed: _saveSubject,
                icon: const Icon(Icons.save),
                label: const Text('Guardar Asignatura'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
