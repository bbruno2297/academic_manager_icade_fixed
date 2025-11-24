import 'package:isar/isar.dart';
import '../models/subject.dart';
import '../services/isar_service.dart';

class SubjectRepository {
  Future<Isar> _getIsar() async {
    return await IsarService.getInstance();
  }

  Future<List<Subject>> getAll() async {
    final isar = await _getIsar();
    return await isar.subjects.where().findAll();
  }

  Future<List<Subject>> getByAcademicYear(int academicYearId) async {
    final isar = await _getIsar();
    final all = await isar.subjects.where().findAll();
    return all.where((s) => s.academicYearId == academicYearId).toList();
  }

  Future<List<Subject>> getByCarrera(Carrera carrera) async {
    final isar = await _getIsar();
    final all = await isar.subjects.where().findAll();
    return all.where((s) => s.carrera == carrera).toList();
  }

  Future<Subject?> getById(int id) async {
    final isar = await _getIsar();
    return await isar.subjects.get(id);
  }

  Future<int> create(Subject subject) async {
    final isar = await _getIsar();
    return await isar.writeTxn(() async {
      return await isar.subjects.put(subject);
    });
  }

  Future<void> update(Subject subject) async {
    final isar = await _getIsar();
    subject.updatedAt = DateTime.now();
    await isar.writeTxn(() async {
      await isar.subjects.put(subject);
    });
  }

  Future<void> updateNotaFinal(int subjectId, double nuevaNota) async {
    final isar = await _getIsar();
    final subject = await isar.subjects.get(subjectId);
    if (subject != null) {
      subject.notaFinal = nuevaNota;
      subject.updatedAt = DateTime.now();
      await isar.writeTxn(() async {
        await isar.subjects.put(subject);
      });
    }
  }

  Future<void> delete(int subjectId) async {
    final isar = await _getIsar();
    await isar.writeTxn(() async {
      await isar.subjects.delete(subjectId);
    });
  }

  Stream<List<Subject>> watchAll() async* {
    final isar = await _getIsar();
    yield* isar.subjects.where().watch(fireImmediately: true);
  }

  Stream<List<Subject>> watchByAcademicYear(int academicYearId) async* {
    final isar = await _getIsar();
    await for (final all
        in isar.subjects.where().watch(fireImmediately: true)) {
      yield all.where((s) => s.academicYearId == academicYearId).toList();
    }
  }
}
