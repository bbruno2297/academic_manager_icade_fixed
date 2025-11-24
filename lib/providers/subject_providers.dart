import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/subject.dart';
import '../models/academic_year.dart';
import '../repositories/subject_repository.dart';
import '../repositories/academic_year_repository.dart';
import '../services/calculation_service.dart';

final subjectRepositoryProvider = Provider<SubjectRepository>((ref) {
  return SubjectRepository();
});

final academicYearRepositoryProvider = Provider<AcademicYearRepository>((ref) {
  return AcademicYearRepository();
});

final allSubjectsProvider = StreamProvider<List<Subject>>((ref) {
  final repository = ref.watch(subjectRepositoryProvider);
  return repository.watchAll();
});

final currentAcademicYearProvider = FutureProvider<AcademicYear?>((ref) async {
  final repository = ref.watch(academicYearRepositoryProvider);
  return await repository.getCurrentYear();
});

final currentYearSubjectsProvider = StreamProvider<List<Subject>>((ref) async* {
  final currentYearAsync = ref.watch(currentAcademicYearProvider);

  await for (final _ in Stream.periodic(const Duration(milliseconds: 100))) {
    if (currentYearAsync.hasValue && currentYearAsync.value != null) {
      final repository = ref.watch(subjectRepositoryProvider);
      yield* repository.watchByAcademicYear(currentYearAsync.value!.id);
      break;
    }
  }
});

final mediasProvider = Provider<Map<String, double>>((ref) {
  final allSubjectsAsync = ref.watch(allSubjectsProvider);
  final currentYearAsync = ref.watch(currentAcademicYearProvider);

  if (!allSubjectsAsync.hasValue || !currentYearAsync.hasValue) {
    return {
      'mediaCursoDerecho': 0.0,
      'mediaCursoADE': 0.0,
      'mediaCarreraDerecho': 0.0,
      'mediaCarreraADE': 0.0,
    };
  }

  final todasLasAsignaturas = allSubjectsAsync.value ?? [];
  final anioActual = currentYearAsync.value;

  return CalculationService.calcularTodasLasMedias(
    todasLasAsignaturas,
    anioActual?.id,
  );
});

final subjectsBySemestreProvider =
    Provider<Map<Semestre, List<Subject>>>((ref) {
  final currentYearSubjectsAsync = ref.watch(currentYearSubjectsProvider);

  if (!currentYearSubjectsAsync.hasValue) {
    return {
      Semestre.primero: [],
      Semestre.segundo: [],
    };
  }

  final subjects = currentYearSubjectsAsync.value ?? [];

  return {
    Semestre.primero:
        subjects.where((s) => s.semestre == Semestre.primero).toList(),
    Semestre.segundo:
        subjects.where((s) => s.semestre == Semestre.segundo).toList(),
  };
});
