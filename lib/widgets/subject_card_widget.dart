import 'package:flutter/material.dart';
import '../models/subject.dart';
import '../screens/subject_detail_screen.dart';

class SubjectCardWidget extends StatelessWidget {
  final Subject subject;
  final VoidCallback? onTap;

  const SubjectCardWidget({
    super.key,
    required this.subject,
    this.onTap,
  });

  Color _getCarreraColor() {
    switch (subject.carrera) {
      case Carrera.derecho:
        return Colors.blue.shade700;
      case Carrera.ade:
        return Colors.green.shade700;
    }
  }

  String _getCarreraString() {
    switch (subject.carrera) {
      case Carrera.derecho:
        return 'Derecho';
      case Carrera.ade:
        return 'ADE';
    }
  }

  String _getSemestreString() {
    switch (subject.semestre) {
      case Semestre.primero:
        return '1º';
      case Semestre.segundo:
        return '2º';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap ??
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubjectDetailScreen(subject: subject),
                ),
              );
            },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _getCarreraColor().withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.school,
                  color: _getCarreraColor(),
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
                      subject.nombre,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getCarreraColor().withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _getCarreraString(),
                            style: TextStyle(
                              color: _getCarreraColor(),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _getSemestreString(),
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${subject.ects} ECTS',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Nota and edit icon
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (subject.notaFinal > 0) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: subject.notaFinal >= 5
                            ? Colors.green.shade50
                            : Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: subject.notaFinal >= 5
                              ? Colors.green.shade200
                              : Colors.red.shade200,
                        ),
                      ),
                      child: Text(
                        subject.notaFinal.toStringAsFixed(2),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: subject.notaFinal >= 5
                              ? Colors.green.shade700
                              : Colors.red.shade700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ] else ...[
                    Text(
                      'Sin nota',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                  const SizedBox(height: 4),
                  Icon(Icons.edit, size: 18, color: Colors.grey.shade400),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
