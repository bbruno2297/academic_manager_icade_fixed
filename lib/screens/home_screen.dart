import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/app_drawer.dart';
import '../widgets/gestion_notas_widget.dart';
import '../widgets/dashboard/dashboard_layout.dart';
import '../widgets/dashboard/stats_overview_widget.dart';
import 'subjects_management_screen.dart';
import 'calendar_screen.dart';
import 'stats_screen.dart';
import 'academic_years_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return _buildDesktopLayout();
        } else {
          return _buildMobileLayout();
        }
      },
    );
  }

  Widget _buildDesktopLayout() {
    return DashboardLayout(
      selectedIndex: _selectedIndex,
      onItemSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      title: _getTitleForIndex(_selectedIndex),
      child: _getContentForIndex(_selectedIndex),
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Manager'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const AppDrawer(),
      body: const DashboardView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-subject');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  String _getTitleForIndex(int index) {
    switch (index) {
      case 0:
        return 'Resumen General';
      case 1:
        return 'Gestión de Asignaturas';
      case 2:
        return 'Calendario de Evaluaciones';
      case 3:
        return 'Estadísticas y Rendimiento';
      case 4:
        return 'Años Académicos';
      case 5:
        return 'Configuración del Sistema';
      default:
        return '';
    }
  }

  Widget _getContentForIndex(int index) {
    switch (index) {
      case 0:
        return const DashboardView(isDesktop: true);
      case 1:
        return const SubjectsManagementScreen(isEmbedded: true);
      case 2:
        return const CalendarScreen(isEmbedded: true);
      case 3:
        return const StatsScreen(isEmbedded: true);
      case 4:
        return const AcademicYearsScreen();
      case 5:
        return const SettingsScreen();
      default:
        return const Center(child: Text('Página no encontrada'));
    }
  }
}

class DashboardView extends StatelessWidget {
  final bool isDesktop;

  const DashboardView({super.key, this.isDesktop = false});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop) ...[
            const StatsOverviewWidget(),
            const SizedBox(height: 32),
            const Text(
              'Asignaturas Recientes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
          ],
          const GestionNotasWidget(),
        ],
      ),
    );
  }
}
