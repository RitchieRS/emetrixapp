// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_stores.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStoreGeneralCollection on Isar {
  IsarCollection<StoreGeneral> get storeGenerals => this.collection();
}

const StoreGeneralSchema = CollectionSchema(
  name: r'StoreGeneral',
  id: -5324391419747954974,
  properties: {
    r'checkGPS': PropertySchema(
      id: 0,
      name: r'checkGPS',
      type: IsarType.string,
    ),
    r'clasificacion': PropertySchema(
      id: 1,
      name: r'clasificacion',
      type: IsarType.string,
    ),
    r'definirNombre': PropertySchema(
      id: 2,
      name: r'definirNombre',
      type: IsarType.long,
    ),
    r'id': PropertySchema(
      id: 3,
      name: r'id',
      type: IsarType.string,
    ),
    r'idCadena': PropertySchema(
      id: 4,
      name: r'idCadena',
      type: IsarType.string,
    ),
    r'idGrupo': PropertySchema(
      id: 5,
      name: r'idGrupo',
      type: IsarType.string,
    ),
    r'latitud': PropertySchema(
      id: 6,
      name: r'latitud',
      type: IsarType.double,
    ),
    r'longitud': PropertySchema(
      id: 7,
      name: r'longitud',
      type: IsarType.double,
    ),
    r'rangoGPS': PropertySchema(
      id: 8,
      name: r'rangoGPS',
      type: IsarType.long,
    ),
    r'tienda': PropertySchema(
      id: 9,
      name: r'tienda',
      type: IsarType.string,
    )
  },
  estimateSize: _storeGeneralEstimateSize,
  serialize: _storeGeneralSerialize,
  deserialize: _storeGeneralDeserialize,
  deserializeProp: _storeGeneralDeserializeProp,
  idName: r'idIsar',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _storeGeneralGetId,
  getLinks: _storeGeneralGetLinks,
  attach: _storeGeneralAttach,
  version: '3.1.0+1',
);

int _storeGeneralEstimateSize(
  StoreGeneral object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.checkGPS;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.clasificacion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.id;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.idCadena;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.idGrupo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.tienda;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _storeGeneralSerialize(
  StoreGeneral object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.checkGPS);
  writer.writeString(offsets[1], object.clasificacion);
  writer.writeLong(offsets[2], object.definirNombre);
  writer.writeString(offsets[3], object.id);
  writer.writeString(offsets[4], object.idCadena);
  writer.writeString(offsets[5], object.idGrupo);
  writer.writeDouble(offsets[6], object.latitud);
  writer.writeDouble(offsets[7], object.longitud);
  writer.writeLong(offsets[8], object.rangoGPS);
  writer.writeString(offsets[9], object.tienda);
}

StoreGeneral _storeGeneralDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StoreGeneral(
    checkGPS: reader.readStringOrNull(offsets[0]),
    clasificacion: reader.readStringOrNull(offsets[1]),
    definirNombre: reader.readLongOrNull(offsets[2]),
    id: reader.readStringOrNull(offsets[3]),
    idCadena: reader.readStringOrNull(offsets[4]),
    idGrupo: reader.readStringOrNull(offsets[5]),
    latitud: reader.readDoubleOrNull(offsets[6]),
    longitud: reader.readDoubleOrNull(offsets[7]),
    rangoGPS: reader.readLongOrNull(offsets[8]),
    tienda: reader.readStringOrNull(offsets[9]),
  );
  object.idIsar = id;
  return object;
}

P _storeGeneralDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readDoubleOrNull(offset)) as P;
    case 7:
      return (reader.readDoubleOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _storeGeneralGetId(StoreGeneral object) {
  return object.idIsar;
}

List<IsarLinkBase<dynamic>> _storeGeneralGetLinks(StoreGeneral object) {
  return [];
}

void _storeGeneralAttach(
    IsarCollection<dynamic> col, Id id, StoreGeneral object) {
  object.idIsar = id;
}

extension StoreGeneralQueryWhereSort
    on QueryBuilder<StoreGeneral, StoreGeneral, QWhere> {
  QueryBuilder<StoreGeneral, StoreGeneral, QAfterWhere> anyIdIsar() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension StoreGeneralQueryWhere
    on QueryBuilder<StoreGeneral, StoreGeneral, QWhereClause> {
  QueryBuilder<StoreGeneral, StoreGeneral, QAfterWhereClause> idIsarEqualTo(
      Id idIsar) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: idIsar,
        upper: idIsar,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterWhereClause> idIsarNotEqualTo(
      Id idIsar) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: idIsar, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: idIsar, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: idIsar, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: idIsar, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterWhereClause> idIsarGreaterThan(
      Id idIsar,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: idIsar, includeLower: include),
      );
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterWhereClause> idIsarLessThan(
      Id idIsar,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: idIsar, includeUpper: include),
      );
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterWhereClause> idIsarBetween(
    Id lowerIdIsar,
    Id upperIdIsar, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIdIsar,
        includeLower: includeLower,
        upper: upperIdIsar,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension StoreGeneralQueryFilter
    on QueryBuilder<StoreGeneral, StoreGeneral, QFilterCondition> {
  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      checkGPSIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'checkGPS',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      checkGPSIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'checkGPS',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      checkGPSEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'checkGPS',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      checkGPSGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'checkGPS',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      checkGPSLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'checkGPS',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      checkGPSBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'checkGPS',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      checkGPSStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'checkGPS',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      checkGPSEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'checkGPS',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      checkGPSContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'checkGPS',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      checkGPSMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'checkGPS',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      checkGPSIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'checkGPS',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      checkGPSIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'checkGPS',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      clasificacionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'clasificacion',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      clasificacionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'clasificacion',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      clasificacionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clasificacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      clasificacionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clasificacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      clasificacionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clasificacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      clasificacionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clasificacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      clasificacionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'clasificacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      clasificacionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'clasificacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      clasificacionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clasificacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      clasificacionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clasificacion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      clasificacionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clasificacion',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      clasificacionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clasificacion',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      definirNombreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'definirNombre',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      definirNombreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'definirNombre',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      definirNombreEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'definirNombre',
        value: value,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      definirNombreGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'definirNombre',
        value: value,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      definirNombreLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'definirNombre',
        value: value,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      definirNombreBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'definirNombre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition> idEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition> idGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition> idLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition> idBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idCadenaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'idCadena',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idCadenaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'idCadena',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idCadenaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idCadena',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idCadenaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idCadena',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idCadenaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idCadena',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idCadenaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idCadena',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idCadenaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'idCadena',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idCadenaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'idCadena',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idCadenaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'idCadena',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idCadenaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'idCadena',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idCadenaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idCadena',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idCadenaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'idCadena',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idGrupoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'idGrupo',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idGrupoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'idGrupo',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idGrupoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idGrupo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idGrupoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idGrupo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idGrupoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idGrupo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idGrupoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idGrupo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idGrupoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'idGrupo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idGrupoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'idGrupo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idGrupoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'idGrupo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idGrupoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'idGrupo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idGrupoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idGrupo',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idGrupoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'idGrupo',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition> idIsarEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idIsar',
        value: value,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idIsarGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idIsar',
        value: value,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      idIsarLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idIsar',
        value: value,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition> idIsarBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idIsar',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      latitudIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'latitud',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      latitudIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'latitud',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      latitudEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latitud',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      latitudGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'latitud',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      latitudLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'latitud',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      latitudBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'latitud',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      longitudIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'longitud',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      longitudIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'longitud',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      longitudEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longitud',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      longitudGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longitud',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      longitudLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longitud',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      longitudBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longitud',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      rangoGPSIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rangoGPS',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      rangoGPSIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rangoGPS',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      rangoGPSEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rangoGPS',
        value: value,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      rangoGPSGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rangoGPS',
        value: value,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      rangoGPSLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rangoGPS',
        value: value,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      rangoGPSBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rangoGPS',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      tiendaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tienda',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      tiendaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tienda',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition> tiendaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tienda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      tiendaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tienda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      tiendaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tienda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition> tiendaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tienda',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      tiendaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tienda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      tiendaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tienda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      tiendaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tienda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition> tiendaMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tienda',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      tiendaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tienda',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterFilterCondition>
      tiendaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tienda',
        value: '',
      ));
    });
  }
}

extension StoreGeneralQueryObject
    on QueryBuilder<StoreGeneral, StoreGeneral, QFilterCondition> {}

extension StoreGeneralQueryLinks
    on QueryBuilder<StoreGeneral, StoreGeneral, QFilterCondition> {}

extension StoreGeneralQuerySortBy
    on QueryBuilder<StoreGeneral, StoreGeneral, QSortBy> {
  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> sortByCheckGPS() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checkGPS', Sort.asc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> sortByCheckGPSDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checkGPS', Sort.desc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> sortByClasificacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clasificacion', Sort.asc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy>
      sortByClasificacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clasificacion', Sort.desc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> sortByDefinirNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'definirNombre', Sort.asc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy>
      sortByDefinirNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'definirNombre', Sort.desc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> sortByIdCadena() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idCadena', Sort.asc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> sortByIdCadenaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idCadena', Sort.desc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> sortByIdGrupo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idGrupo', Sort.asc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> sortByIdGrupoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idGrupo', Sort.desc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> sortByLatitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitud', Sort.asc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> sortByLatitudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitud', Sort.desc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> sortByLongitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitud', Sort.asc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> sortByLongitudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitud', Sort.desc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> sortByRangoGPS() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rangoGPS', Sort.asc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> sortByRangoGPSDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rangoGPS', Sort.desc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> sortByTienda() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tienda', Sort.asc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> sortByTiendaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tienda', Sort.desc);
    });
  }
}

extension StoreGeneralQuerySortThenBy
    on QueryBuilder<StoreGeneral, StoreGeneral, QSortThenBy> {
  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> thenByCheckGPS() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checkGPS', Sort.asc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> thenByCheckGPSDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checkGPS', Sort.desc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> thenByClasificacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clasificacion', Sort.asc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy>
      thenByClasificacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clasificacion', Sort.desc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> thenByDefinirNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'definirNombre', Sort.asc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy>
      thenByDefinirNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'definirNombre', Sort.desc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> thenByIdCadena() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idCadena', Sort.asc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> thenByIdCadenaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idCadena', Sort.desc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> thenByIdGrupo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idGrupo', Sort.asc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> thenByIdGrupoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idGrupo', Sort.desc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> thenByIdIsar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idIsar', Sort.asc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> thenByIdIsarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idIsar', Sort.desc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> thenByLatitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitud', Sort.asc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> thenByLatitudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitud', Sort.desc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> thenByLongitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitud', Sort.asc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> thenByLongitudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitud', Sort.desc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> thenByRangoGPS() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rangoGPS', Sort.asc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> thenByRangoGPSDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rangoGPS', Sort.desc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> thenByTienda() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tienda', Sort.asc);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QAfterSortBy> thenByTiendaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tienda', Sort.desc);
    });
  }
}

extension StoreGeneralQueryWhereDistinct
    on QueryBuilder<StoreGeneral, StoreGeneral, QDistinct> {
  QueryBuilder<StoreGeneral, StoreGeneral, QDistinct> distinctByCheckGPS(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'checkGPS', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QDistinct> distinctByClasificacion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clasificacion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QDistinct>
      distinctByDefinirNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'definirNombre');
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QDistinct> distinctByIdCadena(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idCadena', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QDistinct> distinctByIdGrupo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idGrupo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QDistinct> distinctByLatitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latitud');
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QDistinct> distinctByLongitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longitud');
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QDistinct> distinctByRangoGPS() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rangoGPS');
    });
  }

  QueryBuilder<StoreGeneral, StoreGeneral, QDistinct> distinctByTienda(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tienda', caseSensitive: caseSensitive);
    });
  }
}

extension StoreGeneralQueryProperty
    on QueryBuilder<StoreGeneral, StoreGeneral, QQueryProperty> {
  QueryBuilder<StoreGeneral, int, QQueryOperations> idIsarProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idIsar');
    });
  }

  QueryBuilder<StoreGeneral, String?, QQueryOperations> checkGPSProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'checkGPS');
    });
  }

  QueryBuilder<StoreGeneral, String?, QQueryOperations>
      clasificacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clasificacion');
    });
  }

  QueryBuilder<StoreGeneral, int?, QQueryOperations> definirNombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'definirNombre');
    });
  }

  QueryBuilder<StoreGeneral, String?, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<StoreGeneral, String?, QQueryOperations> idCadenaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idCadena');
    });
  }

  QueryBuilder<StoreGeneral, String?, QQueryOperations> idGrupoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idGrupo');
    });
  }

  QueryBuilder<StoreGeneral, double?, QQueryOperations> latitudProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latitud');
    });
  }

  QueryBuilder<StoreGeneral, double?, QQueryOperations> longitudProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longitud');
    });
  }

  QueryBuilder<StoreGeneral, int?, QQueryOperations> rangoGPSProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rangoGPS');
    });
  }

  QueryBuilder<StoreGeneral, String?, QQueryOperations> tiendaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tienda');
    });
  }
}
