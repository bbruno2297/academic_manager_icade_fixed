import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/academic_year.dart';
import '../providers/academic_year_providers.dart';

class AddAcademicYearScreen extends ConsumerStatefulWidget {
  const AddAcademicYearScreen({super.key});

  @override
  ConsumerState<AddAcademicYearScreen> createState() =>
      _AddAcademicYearScreenState();
}

class _AddAcademicYearScreenState extends ConsumerState<AddAcademicYearScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  DateTime _fechaInicio = DateTime(DateTime.now().year, 9, 1);
  DateTime _fechaFin = DateTime(DateTime.now().year + 1, 6, 30);
  bool _isCurrentYear = false;

  @override
  void dispose() {
    _nombreController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isInicio) async {
    final initialDate = isInicio ? _fechaInicio : _fechaFin;
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        if (isInicio) {
          _fechaInicio = picked;
          // Ajustar fin si es anterior al inicio
          if (_fechaFin.isBefore(_fechaInicio)) {
            _fechaFin = _fechaInicio.add(const Duration(days: 300));
          }
        } else {
          _fechaFin = picked;
        }
      });
    }
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final repository = ref.read(academicYearRepositoryProvider);

      final newYear = AcademicYear()
        ..nombre = _nombreController.text
        ..fechaInicio = _fechaInicio
        ..fechaFin = _fechaFin
        ..isCurrentYear = _isCurrentYear
        ..expedienteId = 1 // Default ID
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now();

      await repository.create(newYear);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Año académico creado correctamente'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Año Académico'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del Curso',
                  hintText: 'Ej: Curso 2024-2025',
                  prefixIcon: Icon(Icons.school),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor introduce un nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate(context, true),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Fecha Inicio',
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        child: Text(
                          DateFormat('dd/MM/yyyy').format(_fechaInicio),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate(context, false),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Fecha Fin',
                          prefixIcon: Icon(Icons.event),
                        ),
                        child: Text(
                          DateFormat('dd/MM/yyyy').format(_fechaFin),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SwitchListTile(
                title: const Text('Marcar como Año Actual'),
                subtitle: const Text(
                    'Las nuevas asignaturas se asociarán a este año por defecto'),
                value: _isCurrentYear,
                onChanged: (value) {
                  setState(() {
                    _isCurrentYear = value;
                  });
                },
                secondary: const Icon(Icons.check_circle_outline),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save),
                  label: const Text('Guardar Año Académico'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
