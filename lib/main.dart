import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'services/isar_service.dart';
import 'screens/home_screen.dart';
import 'screens/subjects_management_screen.dart';
import 'screens/add_subject_screen.dart';
import 'screens/edit_subject_screen.dart';
import 'screens/subject_detail_screen.dart';
import 'screens/add_evaluation_screen.dart';
import 'screens/evaluation_detail_screen.dart';
import 'screens/academic_years_screen.dart';
import 'screens/add_academic_year_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/settings_screen.dart';
import 'providers/theme_provider.dart';
import 'models/subject.dart';
import 'models/evaluation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es', null); // Added line for date formatting
  await IsarService.getInstance();

  // Descomentar para poblar con datos de ejemplo
  // await seedDatabase();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Assuming themeProvider is defined elsewhere, e.g., final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);
    // For this change, I'll assume it exists and just add the line.
    // If themeProvider is not defined, this will cause a compilation error.
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Academic Manager ICADE',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF003366), // Azul ICADE
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF003366), // Azul ICADE
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor:
            const Color(0xFF121212), // Ensure dark background
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/subjects': (context) => const SubjectsManagementScreen(),
        '/add-subject': (context) => const AddSubjectScreen(),
        '/academic-years': (context) => const AcademicYearsScreen(),
        '/add-academic-year': (context) => const AddAcademicYearScreen(),
        '/calendar': (context) => const CalendarScreen(),
        '/stats': (context) => const StatsScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
      onGenerateRoute: (settings) {
        // Handle routes that need arguments
        if (settings.name == '/edit-subject') {
          final subject = settings.arguments as Subject;
          return MaterialPageRoute(
            builder: (context) => EditSubjectScreen(subject: subject),
          );
        }
        if (settings.name == '/subject-detail') {
          final subject = settings.arguments as Subject;
          return MaterialPageRoute(
            builder: (context) => SubjectDetailScreen(subject: subject),
          );
        }
        if (settings.name == '/add-evaluation') {
          final int? subjectId = settings.arguments as int?;
          return MaterialPageRoute(
            builder: (context) =>
                AddEvaluationScreen(preselectedSubjectId: subjectId),
          );
        }
        if (settings.name == '/evaluation-detail') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => EvaluationDetailScreen(
              evaluation: args['evaluation'] as Evaluation,
              subject: args['subject'] as Subject,
            ),
          );
        }
        return null;
      },
    );
  }
}
