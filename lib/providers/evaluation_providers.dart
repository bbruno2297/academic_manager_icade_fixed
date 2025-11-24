import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/evaluation.dart';
import '../repositories/evaluation_repository.dart';

final evaluationRepositoryProvider = Provider<EvaluationRepository>((ref) {
  return EvaluationRepository();
});

final allEvaluationsProvider = StreamProvider<List<Evaluation>>((ref) {
  final repository = ref.watch(evaluationRepositoryProvider);
  return repository.watchAll();
});

final proximasEvaluationsProvider = StreamProvider<List<Evaluation>>((ref) {
  final repository = ref.watch(evaluationRepositoryProvider);
  return repository.watchProximas();
});

// Provider for evaluations by subject - requires parameter
final evaluationsBySubjectProvider =
    StreamProvider.family<List<Evaluation>, int>((ref, subjectId) {
  final repository = ref.watch(evaluationRepositoryProvider);
  return repository.watchBySubject(subjectId);
});
