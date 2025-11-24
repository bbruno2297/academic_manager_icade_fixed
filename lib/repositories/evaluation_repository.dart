import 'package:isar/isar.dart';
import '../models/evaluation.dart';
import '../services/isar_service.dart';

class EvaluationRepository {
  Future<Isar> _getIsar() async {
    return await IsarService.getInstance();
  }

  Future<List<Evaluation>> getAll() async {
    final isar = await _getIsar();
    return await isar.evaluations.where().findAll();
  }

  Future<List<Evaluation>> getBySubject(int subjectId) async {
    final isar = await _getIsar();
    final all = await isar.evaluations.where().findAll();
    return all.where((e) => e.subjectId == subjectId).toList();
  }

  Future<List<Evaluation>> getProximas() async {
    final isar = await _getIsar();
    final all = await isar.evaluations.where().findAll();
    return all.where((e) => e.esProxima).toList()
      ..sort((a, b) => a.fecha.compareTo(b.fecha));
  }

  Future<int> create(Evaluation evaluation) async {
    final isar = await _getIsar();
    return await isar.writeTxn(() async {
      return await isar.evaluations.put(evaluation);
    });
  }

  Future<void> update(Evaluation evaluation) async {
    final isar = await _getIsar();
    evaluation.updatedAt = DateTime.now();
    await isar.writeTxn(() async {
      await isar.evaluations.put(evaluation);
    });
  }

  Future<void> updateEstado(int id, EstadoEvaluacion nuevoEstado) async {
    final isar = await _getIsar();
    final evaluation = await isar.evaluations.get(id);
    if (evaluation != null) {
      evaluation.estado = nuevoEstado;
      evaluation.updatedAt = DateTime.now();
      await isar.writeTxn(() async {
        await isar.evaluations.put(evaluation);
      });
    }
  }

  Future<void> updateNotaInformativa(int id, double nota) async {
    final isar = await _getIsar();
    final evaluation = await isar.evaluations.get(id);
    if (evaluation != null) {
      evaluation.notaInformativa = nota;
      evaluation.updatedAt = DateTime.now();
      await isar.writeTxn(() async {
        await isar.evaluations.put(evaluation);
      });
    }
  }

  Future<void> delete(int id) async {
    final isar = await _getIsar();
    await isar.writeTxn(() async {
      await isar.evaluations.delete(id);
    });
  }

  Stream<List<Evaluation>> watchAll() async* {
    final isar = await _getIsar();
    yield* isar.evaluations.where().watch(fireImmediately: true);
  }

  Stream<List<Evaluation>> watchBySubject(int subjectId) async* {
    final isar = await _getIsar();
    await for (final all
        in isar.evaluations.where().watch(fireImmediately: true)) {
      yield all.where((e) => e.subjectId == subjectId).toList();
    }
  }

  Stream<List<Evaluation>> watchProximas() async* {
    final isar = await _getIsar();
    await for (final all
        in isar.evaluations.where().watch(fireImmediately: true)) {
      final proximas = all.where((e) => e.esProxima).toList()
        ..sort((a, b) => a.fecha.compareTo(b.fecha));
      yield proximas;
    }
  }
}
