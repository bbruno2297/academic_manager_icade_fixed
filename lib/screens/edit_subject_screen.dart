import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/subject.dart';
import '../providers/subject_providers.dart';
import '../utils/form_validators.dart';

class EditSubjectScreen extends ConsumerStatefulWidget {
  final Subject subject;

  const EditSubjectScreen({super.key, required this.subject});

  @override
  ConsumerState<EditSubjectScreen> createState() => _EditSubjectScreenState();
}

class _EditSubjectScreenState extends ConsumerState<EditSubjectScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _ectsController;
  late TextEditingController _notaFinalController;

  late Carrera _selectedCarrera;
  late Semestre _selectedSemestre;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.subject.nombre);
    _ectsController =
        TextEditingController(text: widget.subject.ects.toString());
    _notaFinalController = TextEditingController(
      text: widget.subject.notaFinal > 0
          ? widget.subject.notaFinal.toString()
          : '',
    );
    _selectedCarrera = widget.subject.carrera;
    _selectedSemestre = widget.subject.semestre;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _ectsController.dispose();
    _notaFinalController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final updatedSubject = widget.subject
      ..nombre = _nombreController.text.trim()
      ..carrera = _selectedCarrera
      ..semestre = _selectedSemestre
      ..ects = double.parse(_ectsController.text)
      ..notaFinal = _notaFinalController.text.isEmpty
          ? 0.0
          : double.parse(_notaFinalController.text);

    try {
      await ref.read(subjectRepositoryProvider).update(updatedSubject);

      if (mounted) {
        Navigator.pop(context, true); // Return true to indicate success
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Asignatura actualizada correctamente'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al actualizar asignatura: $e'),
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
        title: const Text('Editar Asignatura'),
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
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: FormValidators.validateECTS,
              ),
              const SizedBox(height: 20),

              // Nota Final
              TextFormField(
                controller: _notaFinalController,
                decoration: const InputDecoration(
                  labelText: 'Nota Final',
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

              // Botones
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _saveChanges,
                      icon: const Icon(Icons.save),
                      label: const Text('Guardar'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
