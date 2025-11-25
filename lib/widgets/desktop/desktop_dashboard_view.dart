import 'package:flutter/material.dart';
import 'upcoming_events_panel.dart';
import 'weekly_schedule_grid.dart';
import 'tasks_panel.dart';

/// Dashboard desktop MINIMALISTA
/// Solo 3 componentes: Horario (arriba full), Eventos (abajo izq), Tareas (abajo der)
class DesktopDashboardView extends StatelessWidget {
  const DesktopDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // HORARIO SEMANAL - Arriba, full width
          const WeeklyScheduleGrid(),

          const SizedBox(height: 16),

          // Fila inferior: Próximos Eventos (izq) + Tareas (der)
          SizedBox(
            height: 320, // Fixed height for bottom panels
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                // Próximos Eventos - Izquierda
                Expanded(
                  flex: 1,
                  child: UpcomingEventsPanel(),
                ),

                SizedBox(width: 16),

                // Tareas - Derecha
                Expanded(
                  flex: 1,
                  child: TasksPanel(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
