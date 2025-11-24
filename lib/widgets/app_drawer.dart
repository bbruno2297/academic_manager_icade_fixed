import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.school,
                  size: 48,
                  color: Colors.white,
                ),
                SizedBox(height: 12),
                Text(
                  'Academic Manager',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'ICADE',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Dashboard
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/');
            },
          ),

          // Gestión de Asignaturas
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Gestión de Asignaturas'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/subjects');
            },
          ),

          const Divider(),

          // Calendario
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Calendario'),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Phase 2',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.orange.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Calendario - Disponible en Phase 2'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),

          // Estadísticas
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Estadísticas'),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Phase 2',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.orange.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Estadísticas - Disponible en Phase 2'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),

          // Años Académicos
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: const Text('Años Académicos'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/academic-years');
            },
          ),

          const Divider(),

          // Configuración
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Phase 3',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Configuración - Disponible en Phase 3'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),

          // Acerca de
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Acerca de'),
            onTap: () {
              Navigator.pop(context);
              showAboutDialog(
                context: context,
                applicationName: 'Academic Manager ICADE',
                applicationVersion: '1.0.0',
                applicationIcon: const Icon(Icons.school, size: 48),
                children: [
                  const Text(
                    'Aplicación de gestión académica para el Doble Grado en Derecho y ADE del ICADE.',
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Características:\n'
                    '• Gestión de asignaturas\n'
                    '• Calendario de evaluaciones\n'
                    '• Cálculo automático de medias\n'
                    '• Estadísticas de rendimiento',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
