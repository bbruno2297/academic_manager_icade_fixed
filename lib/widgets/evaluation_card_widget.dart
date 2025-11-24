import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/evaluation.dart';
import '../models/subject.dart';
import '../screens/evaluation_detail_screen.dart';

class EvaluationCardWidget extends StatelessWidget {
  final Evaluation evaluation;
  final Subject subject;

  const EvaluationCardWidget({
    super.key,
    required this.evaluation,
    required this.subject,
  });

  Color _getTipoColor() {
    switch (evaluation.tipo) {
      case TipoEvaluacion.parcial:
        return Colors.blue;
      case TipoEvaluacion.final_:
        return Colors.red;
      case TipoEvaluacion.practica:
        return Colors.green;
    }
  }

  String _getTipoString() {
    switch (evaluation.tipo) {
      case TipoEvaluacion.parcial:
        return 'Parcial';
      case TipoEvaluacion.final_:
        return 'Final';
      case TipoEvaluacion.practica:
        return 'Práctica';
    }
  }

  String _getEstadoString() {
    switch (evaluation.estado) {
      case EstadoEvaluacion.pendiente:
        return 'Pendiente';
      case EstadoEvaluacion.esperandoNota:
        return 'Esperando Nota';
      case EstadoEvaluacion.corregido:
        return 'Corregido';
    }
  }

  Color _getEstadoColor() {
    switch (evaluation.estado) {
      case EstadoEvaluacion.pendiente:
        return Colors.orange;
      case EstadoEvaluacion.esperandoNota:
        return Colors.blue;
      case EstadoEvaluacion.corregido:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EvaluationDetailScreen(
                evaluation: evaluation,
                subject: subject,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon and tipo
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getTipoColor().withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.assignment,
                  color: _getTipoColor(),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      evaluation.titulo,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subject.nombre,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.calendar_today,
                            size: 14, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat('dd/MM/yyyy - HH:mm')
                              .format(evaluation.fecha),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        // Tipo badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getTipoColor().withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: _getTipoColor().withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            _getTipoString(),
                            style: TextStyle(
                              color: _getTipoColor(),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Estado badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getEstadoColor().withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color:
                                    _getEstadoColor().withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            _getEstadoString(),
                            style: TextStyle(
                              color: _getEstadoColor(),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Arrow icon
              Icon(Icons.chevron_right, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }
}
