import 'package:isar/isar.dart';

part 'subject.g.dart';

enum Carrera {
  derecho,
  ade,
}

enum Semestre {
  primero,
  segundo,
}

@collection
class Subject {
  Id id = Isar.autoIncrement;

  @Index()
  int academicYearId = 0;

  String nombre = 'Nueva Asignatura';

  @Enumerated(EnumType.name)
  Carrera carrera = Carrera.derecho;

  @Enumerated(EnumType.name)
  Semestre semestre = Semestre.primero;

  double ects = 6.0;
  double notaFinal = 0.0;

  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  bool get cuentaParaMedia => notaFinal > 0;
}
