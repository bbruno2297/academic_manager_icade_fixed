import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Apariencia',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          SwitchListTile(
            title: const Text('Modo Oscuro'),
            subtitle: const Text('Activar tema oscuro para la aplicación'),
            secondary: Icon(
              themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
            ),
            value: themeMode == ThemeMode.dark,
            onChanged: (value) {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Información',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Versión'),
            subtitle: Text('1.0.0 (Phase 2 Complete)'),
          ),
          const ListTile(
            leading: Icon(Icons.school),
            title: Text('Academic Manager ICADE'),
            subtitle: Text('Gestor académico personal'),
          ),
        ],
      ),
    );
  }
}
