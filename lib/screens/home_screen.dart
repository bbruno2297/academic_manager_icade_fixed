import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/subject_providers.dart';
import '../widgets/marcador_widget.dart';
import '../widgets/agenda_widget.dart';
import '../widgets/gestion_notas_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medias = ref.watch(mediasProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Manager ICADE'),
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MarcadorWidget(medias: medias),
            const SizedBox(height: 20),
            const AgendaWidget(),
            const SizedBox(height: 20),
            const GestionNotasWidget(),
            const SizedBox(height: 40),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Anadir asignatura - Proximamente')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
