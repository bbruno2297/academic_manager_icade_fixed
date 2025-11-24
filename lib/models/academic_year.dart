import 'package:isar/isar.dart';

part 'academic_year.g.dart';

@collection
class AcademicYear {
  Id id = Isar.autoIncrement;

  @Index()
  int expedienteId = 1;

  String nombre = 'Curso Academico';
  DateTime fechaInicio = DateTime.now();
  DateTime fechaFin = DateTime.now();

  @Index()
  bool isCurrentYear = false;

  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
}
