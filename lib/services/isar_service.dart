import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/expediente.dart';
import '../models/academic_year.dart';
import '../models/subject.dart';
import '../models/evaluation.dart';

class IsarService {
  static Isar? _isar;

  static Future<Isar> getInstance() async {
    if (_isar != null && _isar!.isOpen) {
      return _isar!;
    }

    final dir = await getApplicationDocumentsDirectory();
    
    _isar = await Isar.open(
      [
        ExpedienteSchema,
        AcademicYearSchema,
        SubjectSchema,
        EvaluationSchema,
      ],
      directory: dir.path,
      name: 'academic_manager_icade',
    );

    return _isar!;
  }

  static Future<void> close() async {
    if (_isar != null && _isar!.isOpen) {
      await _isar!.close();
      _isar = null;
    }
  }
}
