import 'package:flutter/material.dart';

/// Widget que muestra el horario semanal de clases en formato grid
/// REDISEÑADO con estilo DESKTOP - flat, denso, profesional
class WeeklyScheduleGrid extends StatelessWidget {
  const WeeklyScheduleGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF2C2C2C) : Colors.white;
    final borderColor =
        isDark ? const Color(0xFF404040) : const Color(0xFFE0E0E0);
    final headerBg = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F7FA);

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(4), // Minimal rounding
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header - MUY COMPACTO
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: headerBg,
              border: Border(bottom: BorderSide(color: borderColor, width: 1)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_view_week,
                  color: Theme.of(context).colorScheme.primary,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Horario Semanal',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                    letterSpacing: 0.2,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    // TODO: Abrir editor de horario
                  },
                  icon: const Icon(Icons.edit_outlined, size: 14),
                  label: const Text('Editar', style: TextStyle(fontSize: 12)),
                  style: TextButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    minimumSize: const Size(0, 28),
                  ),
                ),
              ],
            ),
          ),

          // Tabla de horario - MÁS COMPACTA
          Padding(
            padding: const EdgeInsets.all(12),
            child: Table(
              border: TableBorder.all(
                color: borderColor,
                width: 1,
              ),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FixedColumnWidth(70),
              },
              children: [
                // Header row
                TableRow(
                  decoration: BoxDecoration(color: headerBg),
                  children: [
                    _buildHeaderCell(context, 'Hora'),
                    _buildHeaderCell(context, 'Lun'),
                    _buildHeaderCell(context, 'Mar'),
                    _buildHeaderCell(context, 'Mié'),
                    _buildHeaderCell(context, 'Jue'),
                    _buildHeaderCell(context, 'Vie'),
                  ],
                ),

                // Time slots - Ejemplo con datos hardcoded
                _buildTimeSlot(
                  context,
                  '9-11',
                  [
                    _ClassBlock('Derecho Civil II', 'Aula 3', Colors.blue),
                    null,
                    _ClassBlock('ADE Financiero', 'Aula 1', Colors.green),
                    _ClassBlock('Derecho Civil II', 'Aula 3', Colors.blue),
                    null,
                  ],
                  isDark,
                ),
                _buildTimeSlot(
                  context,
                  '11-13',
                  [
                    null,
                    _ClassBlock('Derecho Penal', 'Aula 5', Colors.red),
                    null,
                    null,
                    _ClassBlock('Mercantil I', 'Aula 2', Colors.orange),
                  ],
                  isDark,
                ),
                _buildTimeSlot(
                  context,
                  '15-17',
                  [
                    _ClassBlock(
                        'Prácticas Civil', 'Lab 1', Colors.blue.shade300),
                    null,
                    _ClassBlock(
                        'Prácticas ADE', 'Lab 2', Colors.green.shade300),
                    null,
                    null,
                  ],
                  isDark,
                ),
                _buildTimeSlot(
                  context,
                  '17-19',
                  [
                    null,
                    _ClassBlock(
                        'Seminario Penal', 'Sem 3', Colors.red.shade300),
                    null,
                    _ClassBlock(
                        'Tutoría Mercantil', 'Desp 4', Colors.orange.shade300),
                    null,
                  ],
                  isDark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 11,
          color: Theme.of(context).colorScheme.onSurface,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  TableRow _buildTimeSlot(BuildContext context, String time,
      List<_ClassBlock?> classes, bool isDark) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          child: Text(
            time,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        ...classes.map((classBlock) {
          if (classBlock == null) {
            return const SizedBox(height: 50);
          }
          return _buildClassCell(context, classBlock, isDark);
        }),
      ],
    );
  }

  Widget _buildClassCell(
      BuildContext context, _ClassBlock classBlock, bool isDark) {
    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: classBlock.color.withValues(alpha: isDark ? 0.2 : 0.12),
        borderRadius: BorderRadius.circular(2),
        border: Border.all(
          color: classBlock.color.withValues(alpha: isDark ? 0.5 : 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            classBlock.name,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: classBlock.color,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 9,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 2),
              Expanded(
                child: Text(
                  classBlock.location,
                  style: TextStyle(
                    fontSize: 9,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    height: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ClassBlock {
  final String name;
  final String location;
  final Color color;

  _ClassBlock(this.name, this.location, this.color);
}
