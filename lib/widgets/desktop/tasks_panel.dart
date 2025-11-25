import 'package:flutter/material.dart';

/// Panel de tareas - ESTILO DESKTOP
/// Diseño plano, denso, profesional
class TasksPanel extends StatefulWidget {
  const TasksPanel({super.key});

  @override
  State<TasksPanel> createState() => _TasksPanelState();
}

class _TasksPanelState extends State<TasksPanel> {
  // TODO: Conectar con provider/database real
  final List<TaskItem> _tasks = [
    TaskItem('Estudiar Capítulo 3 de Civil', false),
    TaskItem('Hacer práctica de ADE', false),
    TaskItem('Leer apuntes de Penal', true),
    TaskItem('Preparar presentación Mercantil', false),
  ];

  final _newTaskController = TextEditingController();

  @override
  void dispose() {
    _newTaskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pendingCount = _tasks.where((t) => !t.completed).length;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF2C2C2C) : Colors.white;
    final borderColor =
        isDark ? const Color(0xFF404040) : const Color(0xFFE0E0E0);
    final headerBg = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F7FA);

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header compacto
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: headerBg,
              border: Border(bottom: BorderSide(color: borderColor, width: 1)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.checklist_outlined,
                  color: Theme.of(context).colorScheme.primary,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Tareas ($pendingCount)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: _tasks.isEmpty
                ? Center(
                    child: Text(
                      'No hay tareas',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(6),
                    itemCount: _tasks.length,
                    separatorBuilder: (_, __) => Divider(
                      height: 1,
                      color: borderColor,
                      thickness: 1,
                    ),
                    itemBuilder: (context, index) {
                      final task = _tasks[index];
                      return _TaskListItem(
                        task: task,
                        onChanged: (value) {
                          setState(() {
                            task.completed = value ?? false;
                          });
                        },
                        onDelete: () {
                          setState(() {
                            _tasks.removeAt(index);
                          });
                        },
                        isDark: isDark,
                      );
                    },
                  ),
          ),

          // Input de nueva tarea - compacto
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: borderColor, width: 1)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _newTaskController,
                    decoration: InputDecoration(
                      hintText: 'Nueva tarea...',
                      hintStyle: const TextStyle(fontSize: 12),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: BorderSide(color: borderColor),
                      ),
                    ),
                    style: const TextStyle(fontSize: 12),
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        setState(() {
                          _tasks.add(TaskItem(value.trim(), false));
                          _newTaskController.clear();
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 6),
                SizedBox(
                  width: 28,
                  height: 28,
                  child: IconButton(
                    onPressed: () {
                      if (_newTaskController.text.trim().isNotEmpty) {
                        setState(() {
                          _tasks.add(
                              TaskItem(_newTaskController.text.trim(), false));
                          _newTaskController.clear();
                        });
                      }
                    },
                    icon: const Icon(Icons.add, size: 16),
                    tooltip: 'Añadir',
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskListItem extends StatelessWidget {
  final TaskItem task;
  final ValueChanged<bool?>? onChanged;
  final VoidCallback onDelete;
  final bool isDark;

  const _TaskListItem({
    required this.task,
    this.onChanged,
    required this.onDelete,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged?.call(!task.completed),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Row(
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: Checkbox(
                value: task.completed,
                onChanged: onChanged,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                task.title,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.3,
                  decoration:
                      task.completed ? TextDecoration.lineThrough : null,
                  color: task.completed
                      ? Theme.of(context).colorScheme.onSurfaceVariant
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            SizedBox(
              width: 20,
              height: 20,
              child: IconButton(
                icon: const Icon(Icons.close, size: 14),
                onPressed: onDelete,
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                tooltip: 'Eliminar',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskItem {
  String title;
  bool completed;

  TaskItem(this.title, this.completed);
}
