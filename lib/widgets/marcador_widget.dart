import 'package:flutter/material.dart';

class MarcadorWidget extends StatelessWidget {
  final Map<String, double> medias;

  const MarcadorWidget({super.key, required this.medias});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Tu Expediente Academico',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildMediaCard(
                  context,
                  'Derecho\n(Carrera)',
                  medias['mediaCarreraDerecho'] ?? 0.0,
                  Colors.blue.shade700,
                  isLarge: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildMediaCard(
                  context,
                  'ADE\n(Carrera)',
                  medias['mediaCarreraADE'] ?? 0.0,
                  Colors.green.shade700,
                  isLarge: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildMediaCard(
                  context,
                  'Derecho\n(Curso)',
                  medias['mediaCursoDerecho'] ?? 0.0,
                  Colors.blue.shade300,
                  isLarge: false,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildMediaCard(
                  context,
                  'ADE\n(Curso)',
                  medias['mediaCursoADE'] ?? 0.0,
                  Colors.green.shade300,
                  isLarge: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMediaCard(
      BuildContext context, String titulo, double media, Color color,
      {required bool isLarge}) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(isLarge ? 24.0 : 16.0),
        child: Column(
          children: [
            Text(
              titulo,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isLarge ? 16 : 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: isLarge ? 12 : 8),
            Text(
              media == 0.0 ? '--' : media.toStringAsFixed(2),
              style: TextStyle(
                fontSize: isLarge ? 42 : 32,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            if (media > 0) ...[
              SizedBox(height: isLarge ? 8 : 4),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: _getColorByGrade(media).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getTextByGrade(media),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _getColorByGrade(media),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getColorByGrade(double media) {
    if (media >= 9.0) return Colors.green.shade700;
    if (media >= 7.0) return Colors.blue.shade700;
    if (media >= 5.0) return Colors.orange.shade700;
    return Colors.red.shade700;
  }

  String _getTextByGrade(double media) {
    if (media >= 9.0) return 'Sobresaliente';
    if (media >= 7.0) return 'Notable';
    if (media >= 5.0) return 'Aprobado';
    return 'Suspenso';
  }
}
