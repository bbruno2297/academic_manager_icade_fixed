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

final currentAcademicYearProvider = FutureProvider<AcademicYear?>((ref) async {
  final repository = ref.watch(academicYearRepositoryProvider);
  return await repository.getCurrentYear();
});
