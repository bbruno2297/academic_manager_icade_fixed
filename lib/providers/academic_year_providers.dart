import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/academic_year.dart';
import '../repositories/academic_year_repository.dart';

final academicYearRepositoryProvider = Provider<AcademicYearRepository>((ref) {
  return AcademicYearRepository();
});

final allAcademicYearsProvider = StreamProvider<List<AcademicYear>>((ref) {
  final repository = ref.watch(academicYearRepositoryProvider);
  return repository.watchAll();
});

final currentAcademicYearProvider = StreamProvider<AcademicYear?>((ref) {
  final repository = ref.watch(academicYearRepositoryProvider);
  return repository.watchAll().map((years) {
    try {
      return years.firstWhere((y) => y.isCurrentYear);
    } catch (_) {
      return null;
    }
  });
});
