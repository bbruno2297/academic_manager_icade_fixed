// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academic_year.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAcademicYearCollection on Isar {
  IsarCollection<AcademicYear> get academicYears => this.collection();
}

const AcademicYearSchema = CollectionSchema(
  name: r'AcademicYear',
  id: -7718643921016747862,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'expedienteId': PropertySchema(
      id: 1,
      name: r'expedienteId',
      type: IsarType.long,
    ),
    r'fechaFin': PropertySchema(
      id: 2,
      name: r'fechaFin',
      type: IsarType.dateTime,
    ),
    r'fechaInicio': PropertySchema(
      id: 3,
      name: r'fechaInicio',
      type: IsarType.dateTime,
    ),
    r'isCurrentYear': PropertySchema(
      id: 4,
      name: r'isCurrentYear',
      type: IsarType.bool,
    ),
    r'nombre': PropertySchema(
      id: 5,
      name: r'nombre',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 6,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _academicYearEstimateSize,
  serialize: _academicYearSerialize,
  deserialize: _academicYearDeserialize,
  deserializeProp: _academicYearDeserializeProp,
  idName: r'id',
  indexes: {
    r'expedienteId': IndexSchema(
      id: 8200435717011425583,
      name: r'expedienteId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'expedienteId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isCurrentYear': IndexSchema(
      id: -363395209873423175,
      name: r'isCurrentYear',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isCurrentYear',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _academicYearGetId,
  getLinks: _academicYearGetLinks,
  attach: _academicYearAttach,
  version: '3.1.0+1',
);

int _academicYearEstimateSize(
  AcademicYear object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nombre.length * 3;
  return bytesCount;
}

void _academicYearSerialize(
  AcademicYear object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeLong(offsets[1], object.expedienteId);
  writer.writeDateTime(offsets[2], object.fechaFin);
  writer.writeDateTime(offsets[3], object.fechaInicio);
  writer.writeBool(offsets[4], object.isCurrentYear);
  writer.writeString(offsets[5], object.nombre);
  writer.writeDateTime(offsets[6], object.updatedAt);
}

AcademicYear _academicYearDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AcademicYear();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.expedienteId = reader.readLong(offsets[1]);
  object.fechaFin = reader.readDateTime(offsets[2]);
  object.fechaInicio = reader.readDateTime(offsets[3]);
  object.id = id;
  object.isCurrentYear = reader.readBool(offsets[4]);
  object.nombre = reader.readString(offsets[5]);
  object.updatedAt = reader.readDateTime(offsets[6]);
  return object;
}

P _academicYearDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _academicYearGetId(AcademicYear object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _academicYearGetLinks(AcademicYear object) {
  return [];
}

void _academicYearAttach(
    IsarCollection<dynamic> col, Id id, AcademicYear object) {
  object.id = id;
}

extension AcademicYearQueryWhereSort
    on QueryBuilder<AcademicYear, AcademicYear, QWhere> {
  QueryBuilder<AcademicYear, AcademicYear, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterWhere> anyExpedienteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'expedienteId'),
      );
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterWhere> anyIsCurrentYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isCurrentYear'),
      );
    });
  }
}

extension AcademicYearQueryWhere
    on QueryBuilder<AcademicYear, AcademicYear, QWhereClause> {
  QueryBuilder<AcademicYear, AcademicYear, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterWhereClause>
      expedienteIdEqualTo(int expedienteId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'expedienteId',
        value: [expedienteId],
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterWhereClause>
      expedienteIdNotEqualTo(int expedienteId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'expedienteId',
              lower: [],
              upper: [expedienteId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'expedienteId',
              lower: [expedienteId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'expedienteId',
              lower: [expedienteId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'expedienteId',
              lower: [],
              upper: [expedienteId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterWhereClause>
      expedienteIdGreaterThan(
    int expedienteId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'expedienteId',
        lower: [expedienteId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterWhereClause>
      expedienteIdLessThan(
    int expedienteId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'expedienteId',
        lower: [],
        upper: [expedienteId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterWhereClause>
      expedienteIdBetween(
    int lowerExpedienteId,
    int upperExpedienteId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'expedienteId',
        lower: [lowerExpedienteId],
        includeLower: includeLower,
        upper: [upperExpedienteId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterWhereClause>
      isCurrentYearEqualTo(bool isCurrentYear) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isCurrentYear',
        value: [isCurrentYear],
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterWhereClause>
      isCurrentYearNotEqualTo(bool isCurrentYear) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isCurrentYear',
              lower: [],
              upper: [isCurrentYear],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isCurrentYear',
              lower: [isCurrentYear],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isCurrentYear',
              lower: [isCurrentYear],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isCurrentYear',
              lower: [],
              upper: [isCurrentYear],
              includeUpper: false,
            ));
      }
    });
  }
}

extension AcademicYearQueryFilter
    on QueryBuilder<AcademicYear, AcademicYear, QFilterCondition> {
  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      expedienteIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expedienteId',
        value: value,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      expedienteIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expedienteId',
        value: value,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      expedienteIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expedienteId',
        value: value,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      expedienteIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expedienteId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      fechaFinEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaFin',
        value: value,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      fechaFinGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaFin',
        value: value,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      fechaFinLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaFin',
        value: value,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      fechaFinBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaFin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      fechaInicioEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaInicio',
        value: value,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      fechaInicioGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaInicio',
        value: value,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      fechaInicioLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaInicio',
        value: value,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      fechaInicioBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaInicio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      isCurrentYearEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCurrentYear',
        value: value,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition> nombreEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      nombreGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      nombreLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition> nombreBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nombre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      nombreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      nombreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      nombreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition> nombreMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AcademicYearQueryObject
    on QueryBuilder<AcademicYear, AcademicYear, QFilterCondition> {}

extension AcademicYearQueryLinks
    on QueryBuilder<AcademicYear, AcademicYear, QFilterCondition> {}

extension AcademicYearQuerySortBy
    on QueryBuilder<AcademicYear, AcademicYear, QSortBy> {
  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy> sortByExpedienteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expedienteId', Sort.asc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy>
      sortByExpedienteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expedienteId', Sort.desc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy> sortByFechaFin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaFin', Sort.asc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy> sortByFechaFinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaFin', Sort.desc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy> sortByFechaInicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.asc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy>
      sortByFechaInicioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.desc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy> sortByIsCurrentYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCurrentYear', Sort.asc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy>
      sortByIsCurrentYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCurrentYear', Sort.desc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy> sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy> sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension AcademicYearQuerySortThenBy
    on QueryBuilder<AcademicYear, AcademicYear, QSortThenBy> {
  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy> thenByExpedienteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expedienteId', Sort.asc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy>
      thenByExpedienteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expedienteId', Sort.desc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy> thenByFechaFin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaFin', Sort.asc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy> thenByFechaFinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaFin', Sort.desc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy> thenByFechaInicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.asc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy>
      thenByFechaInicioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.desc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy> thenByIsCurrentYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCurrentYear', Sort.asc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy>
      thenByIsCurrentYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCurrentYear', Sort.desc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy> thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy> thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension AcademicYearQueryWhereDistinct
    on QueryBuilder<AcademicYear, AcademicYear, QDistinct> {
  QueryBuilder<AcademicYear, AcademicYear, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QDistinct> distinctByExpedienteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expedienteId');
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QDistinct> distinctByFechaFin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaFin');
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QDistinct> distinctByFechaInicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaInicio');
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QDistinct>
      distinctByIsCurrentYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCurrentYear');
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QDistinct> distinctByNombre(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AcademicYear, AcademicYear, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension AcademicYearQueryProperty
    on QueryBuilder<AcademicYear, AcademicYear, QQueryProperty> {
  QueryBuilder<AcademicYear, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AcademicYear, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<AcademicYear, int, QQueryOperations> expedienteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expedienteId');
    });
  }

  QueryBuilder<AcademicYear, DateTime, QQueryOperations> fechaFinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaFin');
    });
  }

  QueryBuilder<AcademicYear, DateTime, QQueryOperations> fechaInicioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaInicio');
    });
  }

  QueryBuilder<AcademicYear, bool, QQueryOperations> isCurrentYearProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCurrentYear');
    });
  }

  QueryBuilder<AcademicYear, String, QQueryOperations> nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }

  QueryBuilder<AcademicYear, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
