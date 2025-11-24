import 'package:isar/isar.dart';

part 'evaluation.g.dart';

enum TipoEvaluacion {
  parcial,
  final_,
  practica,
}

enum EstadoEvaluacion {
  pendiente,
  esperandoNota,
  corregido,
}

@collection
class Evaluation {
  Id id = Isar.autoIncrement;

  @Index()
  int subjectId = 0;

  String titulo = 'Nueva Evaluacion';
  
  @Index()
  DateTime fecha = DateTime.now();

  @Enumerated(EnumType.name)
  TipoEvaluacion tipo = TipoEvaluacion.parcial;

  @Enumerated(EnumType.name)
  EstadoEvaluacion estado = EstadoEvaluacion.pendiente;

  double notaInformativa = 0.0;

  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  bool get esProxima {
    final ahora = DateTime.now();
    final diferencia = fecha.difference(ahora);
    return diferencia.inDays >= 0 && diferencia.inDays <= 7;
  }
}
