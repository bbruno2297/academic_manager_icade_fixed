import 'package:isar/isar.dart';

part 'expediente.g.dart';

@collection
class Expediente {
  Id id = Isar.autoIncrement;

  @Index()
  String usuarioNombre = 'Usuario';

  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
}
