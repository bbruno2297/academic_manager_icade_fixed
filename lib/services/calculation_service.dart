import '../models/subject.dart';

class CalculationService {
  
  static double calcularMediaPonderada(List<Subject> asignaturas) {
    double sumaNotasPonderadas = 0.0;
    double sumaECTS = 0.0;

    for (final asignatura in asignaturas) {
      if (asignatura.cuentaParaMedia) {
        sumaNotasPonderadas += asignatura.notaFinal * asignatura.ects;
        sumaECTS += asignatura.ects;
      }
    }

    if (sumaECTS == 0) {
      return 0.0;
    }

    return double.parse((sumaNotasPonderadas / sumaECTS).toStringAsFixed(2));
  }

  static List<Subject> filtrarPorCarrera(
    List<Subject> asignaturas, 
    Carrera carrera
  ) {
    return asignaturas.where((s) => s.carrera == carrera).toList();
  }

  static List<Subject> filtrarPorAnioAcademico(
    List<Subject> asignaturas, 
    int academicYearId
  ) {
    return asignaturas.where((s) => s.academicYearId == academicYearId).toList();
  }

  static double calcularMediaCursoDerecho(
    List<Subject> todasLasAsignaturas, 
    int anioActualId
  ) {
    final asignaturasFiltradas = todasLasAsignaturas
        .where((s) => s.academicYearId == anioActualId && s.carrera == Carrera.derecho)
        .toList();
    
    return calcularMediaPonderada(asignaturasFiltradas);
  }

  static double calcularMediaCursoADE(
    List<Subject> todasLasAsignaturas, 
    int anioActualId
  ) {
    final asignaturasFiltradas = todasLasAsignaturas
        .where((s) => s.academicYearId == anioActualId && s.carrera == Carrera.ade)
        .toList();
    
    return calcularMediaPonderada(asignaturasFiltradas);
  }

  static double calcularMediaCarreraDerecho(List<Subject> todasLasAsignaturas) {
    final asignaturasDerecho = filtrarPorCarrera(todasLasAsignaturas, Carrera.derecho);
    return calcularMediaPonderada(asignaturasDerecho);
  }

  static double calcularMediaCarreraADE(List<Subject> todasLasAsignaturas) {
    final asignaturasADE = filtrarPorCarrera(todasLasAsignaturas, Carrera.ade);
    return calcularMediaPonderada(asignaturasADE);
  }

  static Map<String, double> calcularTodasLasMedias(
    List<Subject> todasLasAsignaturas, 
    int? anioActualId
  ) {
    return {
      'mediaCursoDerecho': anioActualId != null 
          ? calcularMediaCursoDerecho(todasLasAsignaturas, anioActualId) 
          : 0.0,
      'mediaCursoADE': anioActualId != null 
          ? calcularMediaCursoADE(todasLasAsignaturas, anioActualId) 
          : 0.0,
      'mediaCarreraDerecho': calcularMediaCarreraDerecho(todasLasAsignaturas),
      'mediaCarreraADE': calcularMediaCarreraADE(todasLasAsignaturas),
    };
  }
}
