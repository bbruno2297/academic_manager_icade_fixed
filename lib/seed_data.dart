import 'models/expediente.dart';
import 'models/academic_year.dart';
import 'models/subject.dart';
import 'models/evaluation.dart';
import 'services/isar_service.dart';

Future<void> seedDatabase() async {
  final isar = await IsarService.getInstance();

  final expedienteCount = await isar.expedientes.count();
  if (expedienteCount > 0) {
    // ignore: avoid_print
    print('Base de datos ya tiene datos.');
    return;
  }

  // ignore: avoid_print
  print('Poblando base de datos...');

  await isar.writeTxn(() async {
    final expediente = Expediente()
      ..usuarioNombre = 'Estudiante ICADE'
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();
    await isar.expedientes.put(expediente);

    final anio2023 = AcademicYear()
      ..expedienteId = 1
      ..nombre = 'Curso 2023-2024'
      ..fechaInicio = DateTime(2023, 9, 1)
      ..fechaFin = DateTime(2024, 6, 30)
      ..isCurrentYear = false
      ..createdAt = DateTime.now();

    final anio2024 = AcademicYear()
      ..expedienteId = 1
      ..nombre = 'Curso 2024-2025'
      ..fechaInicio = DateTime(2024, 9, 1)
      ..fechaFin = DateTime(2025, 6, 30)
      ..isCurrentYear = true
      ..createdAt = DateTime.now();

    await isar.academicYears.putAll([anio2023, anio2024]);

    final asignaturas2023 = [
      Subject()
        ..academicYearId = 1
        ..nombre = 'Derecho Romano'
        ..carrera = Carrera.derecho
        ..semestre = Semestre.primero
        ..ects = 6.0
        ..notaFinal = 7.5
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now(),
      Subject()
        ..academicYearId = 1
        ..nombre = 'Introduccion Economia'
        ..carrera = Carrera.ade
        ..semestre = Semestre.primero
        ..ects = 6.0
        ..notaFinal = 8.5
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now(),
    ];

    await isar.subjects.putAll(asignaturas2023);

    final asignaturas2024 = [
      Subject()
        ..academicYearId = 2
        ..nombre = 'Derecho Civil I'
        ..carrera = Carrera.derecho
        ..semestre = Semestre.primero
        ..ects = 6.0
        ..notaFinal = 8.5
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now(),
      Subject()
        ..academicYearId = 2
        ..nombre = 'Derecho Constitucional'
        ..carrera = Carrera.derecho
        ..semestre = Semestre.primero
        ..ects = 6.0
        ..notaFinal = 0.0
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now(),
      Subject()
        ..academicYearId = 2
        ..nombre = 'Contabilidad Financiera'
        ..carrera = Carrera.ade
        ..semestre = Semestre.primero
        ..ects = 6.0
        ..notaFinal = 7.0
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now(),
      Subject()
        ..academicYearId = 2
        ..nombre = 'Microeconomia'
        ..carrera = Carrera.ade
        ..semestre = Semestre.primero
        ..ects = 6.0
        ..notaFinal = 9.0
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now(),
    ];

    await isar.subjects.putAll(asignaturas2024);

    final evaluaciones = [
      Evaluation()
        ..subjectId = 3
        ..titulo = 'Examen Final'
        ..fecha = DateTime.now().add(const Duration(days: 3))
        ..tipo = TipoEvaluacion.final_
        ..estado = EstadoEvaluacion.pendiente
        ..notaInformativa = 0.0
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now(),
      Evaluation()
        ..subjectId = 5
        ..titulo = 'Practica Final'
        ..fecha = DateTime.now().add(const Duration(days: 5))
        ..tipo = TipoEvaluacion.practica
        ..estado = EstadoEvaluacion.pendiente
        ..notaInformativa = 0.0
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now(),
    ];

    await isar.evaluations.putAll(evaluaciones);
  });

  // ignore: avoid_print
  print('Base de datos poblada!');
}
