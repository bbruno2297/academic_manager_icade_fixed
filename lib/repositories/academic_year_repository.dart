import 'package:isar/isar.dart';
import '../models/academic_year.dart';
import '../models/subject.dart';
import '../services/isar_service.dart';

class AcademicYearRepository {
  Future<Isar> _getIsar() async {
    return await IsarService.getInstance();
  }

  Future<List<AcademicYear>> getAll() async {
    final isar = await _getIsar();
    return await isar.academicYears.where().findAll();
  }

  Future<AcademicYear?> getCurrentYear() async {
    final isar = await _getIsar();
    final allYears = await isar.academicYears.where().findAll();

    for (final year in allYears) {
      if (year.isCurrentYear) {
        return year;
      }
    }

    return null;
  }

  Future<void> setAsCurrent(int yearId) async {
    final isar = await _getIsar();
    final allYears = await isar.academicYears.where().findAll();

    await isar.writeTxn(() async {
      // Deselect all years
      for (final year in allYears) {
        year.isCurrentYear = false;
        await isar.academicYears.put(year);
      }

      // Set the new current year
      final newCurrentYear = await isar.academicYears.get(yearId);
      if (newCurrentYear != null) {
        newCurrentYear.isCurrentYear = true;
        await isar.academicYears.put(newCurrentYear);
      }
    });
  }

  Future<void> create(AcademicYear year) async {
    final isar = await _getIsar();
    await isar.writeTxn(() async {
      await isar.academicYears.put(year);
    });
  }

  Future<void> update(AcademicYear year) async {
    final isar = await _getIsar();
    await isar.writeTxn(() async {
      await isar.academicYears.put(year);
    });
  }

  Future<void> delete(int yearId) async {
    final isar = await _getIsar();

    // Check if year has associated subjects
    final subjects = await isar.subjects.where().findAll();
    final hasSubjects = subjects.any((s) => s.academicYearId == yearId);

    if (hasSubjects) {
      throw Exception(
          'No se puede eliminar un año académico con asignaturas asociadas');
    }

    await isar.writeTxn(() async {
      await isar.academicYears.delete(yearId);
    });
  }

  Stream<List<AcademicYear>> watchAll() async* {
    final isar = await _getIsar();
    yield* isar.academicYears.where().watch(fireImmediately: true);
  }
}
