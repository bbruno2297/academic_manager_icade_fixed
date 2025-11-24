import 'package:flutter/material.dart';

class AgendaWidget extends StatelessWidget {
  const AgendaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 24),
              const SizedBox(width: 8),
              Text(
                'Proximas Evaluaciones',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orange.shade100,
                child: const Icon(Icons.assignment, color: Colors.orange),
              ),
              title: const Text('Examen Derecho Civil'),
              subtitle: const Text('25 Nov 2025 - Examen Final'),
              trailing: Chip(
                label: const Text('Pendiente'),
                backgroundColor: Colors.orange.shade50,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: const Icon(Icons.assignment, color: Colors.blue),
              ),
              title: const Text('Practica Contabilidad'),
              subtitle: const Text('28 Nov 2025 - Entrega'),
              trailing: Chip(
                label: const Text('Pendiente'),
                backgroundColor: Colors.blue.shade50,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.calendar_month),
              label: const Text('Ver calendario completo'),
            ),
          ),
        ],
      ),
    );
  }
}
