import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
import 'models/subject.dart';
import 'models/evaluation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await IsarService.getInstance();

  // Descomentar para poblar con datos de ejemplo
  // await seedDatabase();

  runApp(
    const ProviderScope(
      child: AcademicManagerApp(),
    ),
  );
}

class AcademicManagerApp extends StatelessWidget {
  const AcademicManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Academic Manager ICADE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors
              .blue, // Changed from 0xFF1976D2 to Colors.blue as per instruction
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
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/subjects': (context) => const SubjectsManagementScreen(),
        '/add-subject': (context) => const AddSubjectScreen(),
        '/academic-years': (context) => const AcademicYearsScreen(),
        '/add-academic-year': (context) => const AddAcademicYearScreen(),
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
