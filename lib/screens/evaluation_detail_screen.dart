import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/evaluation.dart';
import '../models/subject.dart';
import '../providers/evaluation_providers.dart';
import '../utils/form_validators.dart';

class EvaluationDetailScreen extends ConsumerStatefulWidget {
  final Evaluation evaluation;
  final Subject subject;

  const EvaluationDetailScreen({
    super.key,
    required this.evaluation,
    required this.subject,
  });

  @override
  ConsumerState<EvaluationDetailScreen> createState() =>
      _EvaluationDetailScreenState();
}

class _EvaluationDetailScreenState
    extends ConsumerState<EvaluationDetailScreen> {
  late TextEditingController _notaInformativaController;
  late EstadoEvaluacion _currentEstado;

  @override
  void initState() {
    super.initState();
    _notaInformativaController = TextEditingController(
      text: widget.evaluation.notaInformativa > 0
          ? widget.evaluation.notaInformativa.toString()
          : '',
    );
    _currentEstado = widget.evaluation.estado;
  }

  @override
  void dispose() {
    _notaInformativaController.dispose();
    super.dispose();
  }

  Future<void> _updateEstado(EstadoEvaluacion nuevoEstado) async {
    try {
      await ref.read(evaluationRepositoryProvider).updateEstado(
            widget.evaluation.id,
            nuevoEstado,
          );
      setState(() {
        _currentEstado = nuevoEstado;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Estado actualizado correctamente'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _saveNotaInformativa() async {
    final nota = _notaInformativaController.text.isEmpty
        ? 0.0
        : double.tryParse(_notaInformativaController.text) ?? 0.0;

    try {
      await ref.read(evaluationRepositoryProvider).updateNotaInformativa(
            widget.evaluation.id,
            nota,
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Nota informativa guardada correctamente'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deleteEvaluation() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text(
            '¿Estás seguro de que quieres eliminar "${widget.evaluation.titulo}"?'),
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

    if (confirmed == true) {
      try {
        await ref
            .read(evaluationRepositoryProvider)
            .delete(widget.evaluation.id);
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Evaluación eliminada correctamente'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Color _getTipoColor() {
    switch (widget.evaluation.tipo) {
      case TipoEvaluacion.parcial:
        return Colors.blue;
      case TipoEvaluacion.final_:
        return Colors.red;
      case TipoEvaluacion.practica:
        return Colors.green;
    }
  }

  String _getTipoString() {
    switch (widget.evaluation.tipo) {
      case TipoEvaluacion.parcial:
        return 'Parcial';
      case TipoEvaluacion.final_:
        return 'Final';
      case TipoEvaluacion.practica:
        return 'Práctica/Entrega';
    }
  }

  String _getEstadoString(EstadoEvaluacion estado) {
    switch (estado) {
      case EstadoEvaluacion.pendiente:
        return 'Pendiente';
      case EstadoEvaluacion.esperandoNota:
        return 'Esperando Nota';
      case EstadoEvaluacion.corregido:
        return 'Corregido';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Evaluación'),
        backgroundColor: _getTipoColor(),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteEvaluation,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Evaluation Info Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.assignment,
                            size: 32, color: _getTipoColor()),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.evaluation.titulo,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.subject.nombre,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    _buildInfoRow('Tipo', _getTipoString(), Icons.category),
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      'Fecha',
                      DateFormat('dd/MM/yyyy - HH:mm')
                          .format(widget.evaluation.fecha),
                      Icons.calendar_today,
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow('Estado', _getEstadoString(_currentEstado),
                        Icons.info_outline),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Estado Actions
            if (_currentEstado == EstadoEvaluacion.pendiente) ...[
              const Text(
                'Marcar como:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () => _updateEstado(EstadoEvaluacion.esperandoNota),
                icon: const Icon(Icons.done),
                label: const Text('Realizada (Esperando Nota)'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
              ),
              const SizedBox(height: 16),
            ],

            if (_currentEstado == EstadoEvaluacion.esperandoNota) ...[
              const Text(
                'Marcar como:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () => _updateEstado(EstadoEvaluacion.corregido),
                icon: const Icon(Icons.check_circle),
                label: const Text('Corregido'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Nota Informativa
            const Text(
              'Nota Informativa',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.orange, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Esta nota NO afecta a la nota final de la asignatura',
                      style: TextStyle(fontSize: 12, color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _notaInformativaController,
                    decoration: const InputDecoration(
                      labelText: 'Nota (0-10)',
                      prefixIcon: Icon(Icons.grade),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    validator: FormValidators.validateNota,
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _saveNotaInformativa,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                  ),
                  child: const Text('Guardar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade600),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
