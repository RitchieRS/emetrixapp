// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sondeo.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSondeosFromStoreCollection on Isar {
  IsarCollection<SondeosFromStore> get sondeosFromStores => this.collection();
}

const SondeosFromStoreSchema = CollectionSchema(
  name: r'SondeosFromStore',
  id: 3029355790919089465,
  properties: {
    r'checkIn': PropertySchema(
      id: 0,
      name: r'checkIn',
      type: IsarType.object,
      target: r'CheckInOut',
    ),
    r'checkOut': PropertySchema(
      id: 1,
      name: r'checkOut',
      type: IsarType.object,
      target: r'CheckInOut',
    ),
    r'sondeo': PropertySchema(
      id: 2,
      name: r'sondeo',
      type: IsarType.object,
      target: r'SondeoModel',
    ),
    r'store': PropertySchema(
      id: 3,
      name: r'store',
      type: IsarType.object,
      target: r'Store2',
    ),
    r'storeSteps': PropertySchema(
      id: 4,
      name: r'storeSteps',
      type: IsarType.objectList,
      target: r'SondeoCollection',
    ),
    r'totalProgress': PropertySchema(
      id: 5,
      name: r'totalProgress',
      type: IsarType.double,
    ),
    r'uuid': PropertySchema(
      id: 6,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _sondeosFromStoreEstimateSize,
  serialize: _sondeosFromStoreSerialize,
  deserialize: _sondeosFromStoreDeserialize,
  deserializeProp: _sondeosFromStoreDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'Store2': Store2Schema,
    r'CheckInOut': CheckInOutSchema,
    r'SondeoModel': SondeoModelSchema,
    r'RespM': RespMSchema,
    r'Preguntas': PreguntasSchema,
    r'Opciones': OpcionesSchema,
    r'SondeoCollection': SondeoCollectionSchema,
    r'QuestionResponse': QuestionResponseSchema
  },
  getId: _sondeosFromStoreGetId,
  getLinks: _sondeosFromStoreGetLinks,
  attach: _sondeosFromStoreAttach,
  version: '3.1.0+1',
);

int _sondeosFromStoreEstimateSize(
  SondeosFromStore object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.checkIn;
    if (value != null) {
      bytesCount += 3 +
          CheckInOutSchema.estimateSize(
              value, allOffsets[CheckInOut]!, allOffsets);
    }
  }
  {
    final value = object.checkOut;
    if (value != null) {
      bytesCount += 3 +
          CheckInOutSchema.estimateSize(
              value, allOffsets[CheckInOut]!, allOffsets);
    }
  }
  {
    final value = object.sondeo;
    if (value != null) {
      bytesCount += 3 +
          SondeoModelSchema.estimateSize(
              value, allOffsets[SondeoModel]!, allOffsets);
    }
  }
  {
    final value = object.store;
    if (value != null) {
      bytesCount +=
          3 + Store2Schema.estimateSize(value, allOffsets[Store2]!, allOffsets);
    }
  }
  {
    final list = object.storeSteps;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[SondeoCollection]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              SondeoCollectionSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.uuid;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _sondeosFromStoreSerialize(
  SondeosFromStore object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<CheckInOut>(
    offsets[0],
    allOffsets,
    CheckInOutSchema.serialize,
    object.checkIn,
  );
  writer.writeObject<CheckInOut>(
    offsets[1],
    allOffsets,
    CheckInOutSchema.serialize,
    object.checkOut,
  );
  writer.writeObject<SondeoModel>(
    offsets[2],
    allOffsets,
    SondeoModelSchema.serialize,
    object.sondeo,
  );
  writer.writeObject<Store2>(
    offsets[3],
    allOffsets,
    Store2Schema.serialize,
    object.store,
  );
  writer.writeObjectList<SondeoCollection>(
    offsets[4],
    allOffsets,
    SondeoCollectionSchema.serialize,
    object.storeSteps,
  );
  writer.writeDouble(offsets[5], object.totalProgress);
  writer.writeString(offsets[6], object.uuid);
}

SondeosFromStore _sondeosFromStoreDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SondeosFromStore(
    checkIn: reader.readObjectOrNull<CheckInOut>(
      offsets[0],
      CheckInOutSchema.deserialize,
      allOffsets,
    ),
    checkOut: reader.readObjectOrNull<CheckInOut>(
      offsets[1],
      CheckInOutSchema.deserialize,
      allOffsets,
    ),
    sondeo: reader.readObjectOrNull<SondeoModel>(
      offsets[2],
      SondeoModelSchema.deserialize,
      allOffsets,
    ),
    store: reader.readObjectOrNull<Store2>(
      offsets[3],
      Store2Schema.deserialize,
      allOffsets,
    ),
    storeSteps: reader.readObjectList<SondeoCollection>(
      offsets[4],
      SondeoCollectionSchema.deserialize,
      allOffsets,
      SondeoCollection(),
    ),
    totalProgress: reader.readDoubleOrNull(offsets[5]),
    uuid: reader.readStringOrNull(offsets[6]),
  );
  object.id = id;
  return object;
}

P _sondeosFromStoreDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<CheckInOut>(
        offset,
        CheckInOutSchema.deserialize,
        allOffsets,
      )) as P;
    case 1:
      return (reader.readObjectOrNull<CheckInOut>(
        offset,
        CheckInOutSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readObjectOrNull<SondeoModel>(
        offset,
        SondeoModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 3:
      return (reader.readObjectOrNull<Store2>(
        offset,
        Store2Schema.deserialize,
        allOffsets,
      )) as P;
    case 4:
      return (reader.readObjectList<SondeoCollection>(
        offset,
        SondeoCollectionSchema.deserialize,
        allOffsets,
        SondeoCollection(),
      )) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _sondeosFromStoreGetId(SondeosFromStore object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _sondeosFromStoreGetLinks(SondeosFromStore object) {
  return [];
}

void _sondeosFromStoreAttach(
    IsarCollection<dynamic> col, Id id, SondeosFromStore object) {
  object.id = id;
}

extension SondeosFromStoreQueryWhereSort
    on QueryBuilder<SondeosFromStore, SondeosFromStore, QWhere> {
  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SondeosFromStoreQueryWhere
    on QueryBuilder<SondeosFromStore, SondeosFromStore, QWhereClause> {
  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterWhereClause> idBetween(
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
}

extension SondeosFromStoreQueryFilter
    on QueryBuilder<SondeosFromStore, SondeosFromStore, QFilterCondition> {
  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      checkInIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'checkIn',
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      checkInIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'checkIn',
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      checkOutIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'checkOut',
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      checkOutIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'checkOut',
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      sondeoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sondeo',
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      sondeoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sondeo',
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      storeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'store',
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      storeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'store',
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      storeStepsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'storeSteps',
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      storeStepsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'storeSteps',
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      storeStepsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'storeSteps',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      storeStepsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'storeSteps',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      storeStepsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'storeSteps',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      storeStepsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'storeSteps',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      storeStepsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'storeSteps',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      storeStepsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'storeSteps',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      totalProgressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'totalProgress',
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      totalProgressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'totalProgress',
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      totalProgressEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalProgress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      totalProgressGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalProgress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      totalProgressLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalProgress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      totalProgressBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalProgress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      uuidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'uuid',
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      uuidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'uuid',
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      uuidEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      uuidGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      uuidLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      uuidBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      uuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      uuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      uuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      uuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension SondeosFromStoreQueryObject
    on QueryBuilder<SondeosFromStore, SondeosFromStore, QFilterCondition> {
  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      checkIn(FilterQuery<CheckInOut> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'checkIn');
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      checkOut(FilterQuery<CheckInOut> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'checkOut');
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      sondeo(FilterQuery<SondeoModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'sondeo');
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition> store(
      FilterQuery<Store2> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'store');
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterFilterCondition>
      storeStepsElement(FilterQuery<SondeoCollection> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'storeSteps');
    });
  }
}

extension SondeosFromStoreQueryLinks
    on QueryBuilder<SondeosFromStore, SondeosFromStore, QFilterCondition> {}

extension SondeosFromStoreQuerySortBy
    on QueryBuilder<SondeosFromStore, SondeosFromStore, QSortBy> {
  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterSortBy>
      sortByTotalProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalProgress', Sort.asc);
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterSortBy>
      sortByTotalProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalProgress', Sort.desc);
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterSortBy>
      sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension SondeosFromStoreQuerySortThenBy
    on QueryBuilder<SondeosFromStore, SondeosFromStore, QSortThenBy> {
  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterSortBy>
      thenByTotalProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalProgress', Sort.asc);
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterSortBy>
      thenByTotalProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalProgress', Sort.desc);
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QAfterSortBy>
      thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension SondeosFromStoreQueryWhereDistinct
    on QueryBuilder<SondeosFromStore, SondeosFromStore, QDistinct> {
  QueryBuilder<SondeosFromStore, SondeosFromStore, QDistinct>
      distinctByTotalProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalProgress');
    });
  }

  QueryBuilder<SondeosFromStore, SondeosFromStore, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension SondeosFromStoreQueryProperty
    on QueryBuilder<SondeosFromStore, SondeosFromStore, QQueryProperty> {
  QueryBuilder<SondeosFromStore, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SondeosFromStore, CheckInOut?, QQueryOperations>
      checkInProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'checkIn');
    });
  }

  QueryBuilder<SondeosFromStore, CheckInOut?, QQueryOperations>
      checkOutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'checkOut');
    });
  }

  QueryBuilder<SondeosFromStore, SondeoModel?, QQueryOperations>
      sondeoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sondeo');
    });
  }

  QueryBuilder<SondeosFromStore, Store2?, QQueryOperations> storeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'store');
    });
  }

  QueryBuilder<SondeosFromStore, List<SondeoCollection>?, QQueryOperations>
      storeStepsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'storeSteps');
    });
  }

  QueryBuilder<SondeosFromStore, double?, QQueryOperations>
      totalProgressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalProgress');
    });
  }

  QueryBuilder<SondeosFromStore, String?, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const SondeoCollectionSchema = Schema(
  name: r'SondeoCollection',
  id: 5887333037325574723,
  properties: {
    r'sondeoProgress': PropertySchema(
      id: 0,
      name: r'sondeoProgress',
      type: IsarType.double,
    ),
    r'sondeos': PropertySchema(
      id: 1,
      name: r'sondeos',
      type: IsarType.objectList,
      target: r'QuestionResponse',
    ),
    r'stepUuid': PropertySchema(
      id: 2,
      name: r'stepUuid',
      type: IsarType.string,
    )
  },
  estimateSize: _sondeoCollectionEstimateSize,
  serialize: _sondeoCollectionSerialize,
  deserialize: _sondeoCollectionDeserialize,
  deserializeProp: _sondeoCollectionDeserializeProp,
);

int _sondeoCollectionEstimateSize(
  SondeoCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.sondeos;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[QuestionResponse]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              QuestionResponseSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.stepUuid;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _sondeoCollectionSerialize(
  SondeoCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.sondeoProgress);
  writer.writeObjectList<QuestionResponse>(
    offsets[1],
    allOffsets,
    QuestionResponseSchema.serialize,
    object.sondeos,
  );
  writer.writeString(offsets[2], object.stepUuid);
}

SondeoCollection _sondeoCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SondeoCollection(
    sondeoProgress: reader.readDoubleOrNull(offsets[0]),
    sondeos: reader.readObjectList<QuestionResponse>(
      offsets[1],
      QuestionResponseSchema.deserialize,
      allOffsets,
      QuestionResponse(),
    ),
    stepUuid: reader.readStringOrNull(offsets[2]),
  );
  return object;
}

P _sondeoCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readObjectList<QuestionResponse>(
        offset,
        QuestionResponseSchema.deserialize,
        allOffsets,
        QuestionResponse(),
      )) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension SondeoCollectionQueryFilter
    on QueryBuilder<SondeoCollection, SondeoCollection, QFilterCondition> {
  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      sondeoProgressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sondeoProgress',
      ));
    });
  }

  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      sondeoProgressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sondeoProgress',
      ));
    });
  }

  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      sondeoProgressEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sondeoProgress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      sondeoProgressGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sondeoProgress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      sondeoProgressLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sondeoProgress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      sondeoProgressBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sondeoProgress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      sondeosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sondeos',
      ));
    });
  }

  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      sondeosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sondeos',
      ));
    });
  }

  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      sondeosLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sondeos',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      sondeosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sondeos',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      sondeosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sondeos',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      sondeosLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sondeos',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      sondeosLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sondeos',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      sondeosLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sondeos',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      stepUuidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stepUuid',
      ));
    });
  }

  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      stepUuidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stepUuid',
      ));
    });
  }

  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      stepUuidEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stepUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      stepUuidGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stepUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      stepUuidLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stepUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      stepUuidBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stepUuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      stepUuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stepUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      stepUuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stepUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      stepUuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stepUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      stepUuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stepUuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      stepUuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stepUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      stepUuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stepUuid',
        value: '',
      ));
    });
  }
}

extension SondeoCollectionQueryObject
    on QueryBuilder<SondeoCollection, SondeoCollection, QFilterCondition> {
  QueryBuilder<SondeoCollection, SondeoCollection, QAfterFilterCondition>
      sondeosElement(FilterQuery<QuestionResponse> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'sondeos');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const QuestionResponseSchema = Schema(
  name: r'QuestionResponse',
  id: -8930199761037548353,
  properties: {
    r'indexSondeo': PropertySchema(
      id: 0,
      name: r'indexSondeo',
      type: IsarType.long,
    ),
    r'question': PropertySchema(
      id: 1,
      name: r'question',
      type: IsarType.object,
      target: r'Preguntas',
    ),
    r'response': PropertySchema(
      id: 2,
      name: r'response',
      type: IsarType.string,
    )
  },
  estimateSize: _questionResponseEstimateSize,
  serialize: _questionResponseSerialize,
  deserialize: _questionResponseDeserialize,
  deserializeProp: _questionResponseDeserializeProp,
);

int _questionResponseEstimateSize(
  QuestionResponse object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.question;
    if (value != null) {
      bytesCount += 3 +
          PreguntasSchema.estimateSize(
              value, allOffsets[Preguntas]!, allOffsets);
    }
  }
  {
    final value = object.response;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _questionResponseSerialize(
  QuestionResponse object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.indexSondeo);
  writer.writeObject<Preguntas>(
    offsets[1],
    allOffsets,
    PreguntasSchema.serialize,
    object.question,
  );
  writer.writeString(offsets[2], object.response);
}

QuestionResponse _questionResponseDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuestionResponse(
    indexSondeo: reader.readLongOrNull(offsets[0]),
    question: reader.readObjectOrNull<Preguntas>(
      offsets[1],
      PreguntasSchema.deserialize,
      allOffsets,
    ),
    response: reader.readStringOrNull(offsets[2]),
  );
  return object;
}

P _questionResponseDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readObjectOrNull<Preguntas>(
        offset,
        PreguntasSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension QuestionResponseQueryFilter
    on QueryBuilder<QuestionResponse, QuestionResponse, QFilterCondition> {
  QueryBuilder<QuestionResponse, QuestionResponse, QAfterFilterCondition>
      indexSondeoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'indexSondeo',
      ));
    });
  }

  QueryBuilder<QuestionResponse, QuestionResponse, QAfterFilterCondition>
      indexSondeoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'indexSondeo',
      ));
    });
  }

  QueryBuilder<QuestionResponse, QuestionResponse, QAfterFilterCondition>
      indexSondeoEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'indexSondeo',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionResponse, QuestionResponse, QAfterFilterCondition>
      indexSondeoGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'indexSondeo',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionResponse, QuestionResponse, QAfterFilterCondition>
      indexSondeoLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'indexSondeo',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionResponse, QuestionResponse, QAfterFilterCondition>
      indexSondeoBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'indexSondeo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuestionResponse, QuestionResponse, QAfterFilterCondition>
      questionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'question',
      ));
    });
  }

  QueryBuilder<QuestionResponse, QuestionResponse, QAfterFilterCondition>
      questionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'question',
      ));
    });
  }

  QueryBuilder<QuestionResponse, QuestionResponse, QAfterFilterCondition>
      responseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'response',
      ));
    });
  }

  QueryBuilder<QuestionResponse, QuestionResponse, QAfterFilterCondition>
      responseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'response',
      ));
    });
  }

  QueryBuilder<QuestionResponse, QuestionResponse, QAfterFilterCondition>
      responseEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'response',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionResponse, QuestionResponse, QAfterFilterCondition>
      responseGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'response',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionResponse, QuestionResponse, QAfterFilterCondition>
      responseLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'response',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionResponse, QuestionResponse, QAfterFilterCondition>
      responseBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'response',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionResponse, QuestionResponse, QAfterFilterCondition>
      responseStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'response',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionResponse, QuestionResponse, QAfterFilterCondition>
      responseEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'response',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionResponse, QuestionResponse, QAfterFilterCondition>
      responseContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'response',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionResponse, QuestionResponse, QAfterFilterCondition>
      responseMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'response',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionResponse, QuestionResponse, QAfterFilterCondition>
      responseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'response',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionResponse, QuestionResponse, QAfterFilterCondition>
      responseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'response',
        value: '',
      ));
    });
  }
}

extension QuestionResponseQueryObject
    on QueryBuilder<QuestionResponse, QuestionResponse, QFilterCondition> {
  QueryBuilder<QuestionResponse, QuestionResponse, QAfterFilterCondition>
      question(FilterQuery<Preguntas> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'question');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CheckInOutSchema = Schema(
  name: r'CheckInOut',
  id: -5338225136621199940,
  properties: {
    r'latitud': PropertySchema(
      id: 0,
      name: r'latitud',
      type: IsarType.string,
    ),
    r'longitud': PropertySchema(
      id: 1,
      name: r'longitud',
      type: IsarType.string,
    ),
    r'picture': PropertySchema(
      id: 2,
      name: r'picture',
      type: IsarType.string,
    )
  },
  estimateSize: _checkInOutEstimateSize,
  serialize: _checkInOutSerialize,
  deserialize: _checkInOutDeserialize,
  deserializeProp: _checkInOutDeserializeProp,
);

int _checkInOutEstimateSize(
  CheckInOut object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.latitud;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.longitud;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.picture;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _checkInOutSerialize(
  CheckInOut object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.latitud);
  writer.writeString(offsets[1], object.longitud);
  writer.writeString(offsets[2], object.picture);
}

CheckInOut _checkInOutDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CheckInOut(
    latitud: reader.readStringOrNull(offsets[0]),
    longitud: reader.readStringOrNull(offsets[1]),
    picture: reader.readStringOrNull(offsets[2]),
  );
  return object;
}

P _checkInOutDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CheckInOutQueryFilter
    on QueryBuilder<CheckInOut, CheckInOut, QFilterCondition> {
  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition> latitudIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'latitud',
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition>
      latitudIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'latitud',
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition> latitudEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latitud',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition>
      latitudGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'latitud',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition> latitudLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'latitud',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition> latitudBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'latitud',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition> latitudStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'latitud',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition> latitudEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'latitud',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition> latitudContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'latitud',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition> latitudMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'latitud',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition> latitudIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latitud',
        value: '',
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition>
      latitudIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'latitud',
        value: '',
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition> longitudIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'longitud',
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition>
      longitudIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'longitud',
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition> longitudEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longitud',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition>
      longitudGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longitud',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition> longitudLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longitud',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition> longitudBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longitud',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition>
      longitudStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'longitud',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition> longitudEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'longitud',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition> longitudContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'longitud',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition> longitudMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'longitud',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition>
      longitudIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longitud',
        value: '',
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition>
      longitudIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'longitud',
        value: '',
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition> pictureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'picture',
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition>
      pictureIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'picture',
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition> pictureEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'picture',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition>
      pictureGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'picture',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition> pictureLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'picture',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition> pictureBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'picture',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition> pictureStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'picture',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition> pictureEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'picture',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition> pictureContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'picture',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition> pictureMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'picture',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition> pictureIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'picture',
        value: '',
      ));
    });
  }

  QueryBuilder<CheckInOut, CheckInOut, QAfterFilterCondition>
      pictureIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'picture',
        value: '',
      ));
    });
  }
}

extension CheckInOutQueryObject
    on QueryBuilder<CheckInOut, CheckInOut, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const SondeoModelSchema = Schema(
  name: r'SondeoModel',
  id: 7602325925862737852,
  properties: {
    r'idError': PropertySchema(
      id: 0,
      name: r'idError',
      type: IsarType.long,
    ),
    r'resp': PropertySchema(
      id: 1,
      name: r'resp',
      type: IsarType.objectList,
      target: r'RespM',
    )
  },
  estimateSize: _sondeoModelEstimateSize,
  serialize: _sondeoModelSerialize,
  deserialize: _sondeoModelDeserialize,
  deserializeProp: _sondeoModelDeserializeProp,
);

int _sondeoModelEstimateSize(
  SondeoModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.resp;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[RespM]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += RespMSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  return bytesCount;
}

void _sondeoModelSerialize(
  SondeoModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.idError);
  writer.writeObjectList<RespM>(
    offsets[1],
    allOffsets,
    RespMSchema.serialize,
    object.resp,
  );
}

SondeoModel _sondeoModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SondeoModel(
    idError: reader.readLongOrNull(offsets[0]),
    resp: reader.readObjectList<RespM>(
      offsets[1],
      RespMSchema.deserialize,
      allOffsets,
      RespM(),
    ),
  );
  return object;
}

P _sondeoModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readObjectList<RespM>(
        offset,
        RespMSchema.deserialize,
        allOffsets,
        RespM(),
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension SondeoModelQueryFilter
    on QueryBuilder<SondeoModel, SondeoModel, QFilterCondition> {
  QueryBuilder<SondeoModel, SondeoModel, QAfterFilterCondition>
      idErrorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'idError',
      ));
    });
  }

  QueryBuilder<SondeoModel, SondeoModel, QAfterFilterCondition>
      idErrorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'idError',
      ));
    });
  }

  QueryBuilder<SondeoModel, SondeoModel, QAfterFilterCondition> idErrorEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idError',
        value: value,
      ));
    });
  }

  QueryBuilder<SondeoModel, SondeoModel, QAfterFilterCondition>
      idErrorGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idError',
        value: value,
      ));
    });
  }

  QueryBuilder<SondeoModel, SondeoModel, QAfterFilterCondition> idErrorLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idError',
        value: value,
      ));
    });
  }

  QueryBuilder<SondeoModel, SondeoModel, QAfterFilterCondition> idErrorBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idError',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SondeoModel, SondeoModel, QAfterFilterCondition> respIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'resp',
      ));
    });
  }

  QueryBuilder<SondeoModel, SondeoModel, QAfterFilterCondition>
      respIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'resp',
      ));
    });
  }

  QueryBuilder<SondeoModel, SondeoModel, QAfterFilterCondition>
      respLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'resp',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<SondeoModel, SondeoModel, QAfterFilterCondition> respIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'resp',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<SondeoModel, SondeoModel, QAfterFilterCondition>
      respIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'resp',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SondeoModel, SondeoModel, QAfterFilterCondition>
      respLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'resp',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<SondeoModel, SondeoModel, QAfterFilterCondition>
      respLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'resp',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SondeoModel, SondeoModel, QAfterFilterCondition>
      respLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'resp',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension SondeoModelQueryObject
    on QueryBuilder<SondeoModel, SondeoModel, QFilterCondition> {
  QueryBuilder<SondeoModel, SondeoModel, QAfterFilterCondition> respElement(
      FilterQuery<RespM> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'resp');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const RespMSchema = Schema(
  name: r'RespM',
  id: -8512446431378863559,
  properties: {
    r'abreLinkWebview': PropertySchema(
      id: 0,
      name: r'abreLinkWebview',
      type: IsarType.long,
    ),
    r'capturaNfc': PropertySchema(
      id: 1,
      name: r'capturaNfc',
      type: IsarType.long,
    ),
    r'capturaSku': PropertySchema(
      id: 2,
      name: r'capturaSku',
      type: IsarType.long,
    ),
    r'id': PropertySchema(
      id: 3,
      name: r'id',
      type: IsarType.string,
    ),
    r'iteracion': PropertySchema(
      id: 4,
      name: r'iteracion',
      type: IsarType.long,
    ),
    r'iterativo': PropertySchema(
      id: 5,
      name: r'iterativo',
      type: IsarType.long,
    ),
    r'linkWeb': PropertySchema(
      id: 6,
      name: r'linkWeb',
      type: IsarType.string,
    ),
    r'noAsistencia': PropertySchema(
      id: 7,
      name: r'noAsistencia',
      type: IsarType.long,
    ),
    r'obligatorio': PropertySchema(
      id: 8,
      name: r'obligatorio',
      type: IsarType.long,
    ),
    r'orden': PropertySchema(
      id: 9,
      name: r'orden',
      type: IsarType.string,
    ),
    r'preguntas': PropertySchema(
      id: 10,
      name: r'preguntas',
      type: IsarType.objectList,
      target: r'Preguntas',
    ),
    r'puntajeTotal': PropertySchema(
      id: 11,
      name: r'puntajeTotal',
      type: IsarType.long,
    ),
    r'sondeo': PropertySchema(
      id: 12,
      name: r'sondeo',
      type: IsarType.string,
    ),
    r'tarea': PropertySchema(
      id: 13,
      name: r'tarea',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(
      id: 14,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _respMEstimateSize,
  serialize: _respMSerialize,
  deserialize: _respMDeserialize,
  deserializeProp: _respMDeserializeProp,
);

int _respMEstimateSize(
  RespM object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.id;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.linkWeb;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.orden;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.preguntas;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[Preguntas]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              PreguntasSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.sondeo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.tarea;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.uuid;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _respMSerialize(
  RespM object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.abreLinkWebview);
  writer.writeLong(offsets[1], object.capturaNfc);
  writer.writeLong(offsets[2], object.capturaSku);
  writer.writeString(offsets[3], object.id);
  writer.writeLong(offsets[4], object.iteracion);
  writer.writeLong(offsets[5], object.iterativo);
  writer.writeString(offsets[6], object.linkWeb);
  writer.writeLong(offsets[7], object.noAsistencia);
  writer.writeLong(offsets[8], object.obligatorio);
  writer.writeString(offsets[9], object.orden);
  writer.writeObjectList<Preguntas>(
    offsets[10],
    allOffsets,
    PreguntasSchema.serialize,
    object.preguntas,
  );
  writer.writeLong(offsets[11], object.puntajeTotal);
  writer.writeString(offsets[12], object.sondeo);
  writer.writeString(offsets[13], object.tarea);
  writer.writeString(offsets[14], object.uuid);
}

RespM _respMDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RespM(
    abreLinkWebview: reader.readLongOrNull(offsets[0]),
    capturaNfc: reader.readLongOrNull(offsets[1]),
    capturaSku: reader.readLongOrNull(offsets[2]),
    id: reader.readStringOrNull(offsets[3]),
    iteracion: reader.readLongOrNull(offsets[4]),
    iterativo: reader.readLongOrNull(offsets[5]),
    linkWeb: reader.readStringOrNull(offsets[6]),
    noAsistencia: reader.readLongOrNull(offsets[7]),
    obligatorio: reader.readLongOrNull(offsets[8]),
    orden: reader.readStringOrNull(offsets[9]),
    preguntas: reader.readObjectList<Preguntas>(
      offsets[10],
      PreguntasSchema.deserialize,
      allOffsets,
      Preguntas(),
    ),
    puntajeTotal: reader.readLongOrNull(offsets[11]),
    sondeo: reader.readStringOrNull(offsets[12]),
    tarea: reader.readStringOrNull(offsets[13]),
    uuid: reader.readStringOrNull(offsets[14]),
  );
  return object;
}

P _respMDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readObjectList<Preguntas>(
        offset,
        PreguntasSchema.deserialize,
        allOffsets,
        Preguntas(),
      )) as P;
    case 11:
      return (reader.readLongOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension RespMQueryFilter on QueryBuilder<RespM, RespM, QFilterCondition> {
  QueryBuilder<RespM, RespM, QAfterFilterCondition> abreLinkWebviewIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'abreLinkWebview',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> abreLinkWebviewIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'abreLinkWebview',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> abreLinkWebviewEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'abreLinkWebview',
        value: value,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> abreLinkWebviewGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'abreLinkWebview',
        value: value,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> abreLinkWebviewLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'abreLinkWebview',
        value: value,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> abreLinkWebviewBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'abreLinkWebview',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> capturaNfcIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'capturaNfc',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> capturaNfcIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'capturaNfc',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> capturaNfcEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'capturaNfc',
        value: value,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> capturaNfcGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'capturaNfc',
        value: value,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> capturaNfcLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'capturaNfc',
        value: value,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> capturaNfcBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'capturaNfc',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> capturaSkuIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'capturaSku',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> capturaSkuIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'capturaSku',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> capturaSkuEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'capturaSku',
        value: value,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> capturaSkuGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'capturaSku',
        value: value,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> capturaSkuLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'capturaSku',
        value: value,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> capturaSkuBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'capturaSku',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<RespM, RespM, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<RespM, RespM, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<RespM, RespM, QAfterFilterCondition> idBetween(
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

  QueryBuilder<RespM, RespM, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<RespM, RespM, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<RespM, RespM, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> iteracionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'iteracion',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> iteracionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'iteracion',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> iteracionEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iteracion',
        value: value,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> iteracionGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'iteracion',
        value: value,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> iteracionLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'iteracion',
        value: value,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> iteracionBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'iteracion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> iterativoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'iterativo',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> iterativoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'iterativo',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> iterativoEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iterativo',
        value: value,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> iterativoGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'iterativo',
        value: value,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> iterativoLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'iterativo',
        value: value,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> iterativoBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'iterativo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> linkWebIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'linkWeb',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> linkWebIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'linkWeb',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> linkWebEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'linkWeb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> linkWebGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'linkWeb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> linkWebLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'linkWeb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> linkWebBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'linkWeb',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> linkWebStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'linkWeb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> linkWebEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'linkWeb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> linkWebContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'linkWeb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> linkWebMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'linkWeb',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> linkWebIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'linkWeb',
        value: '',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> linkWebIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'linkWeb',
        value: '',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> noAsistenciaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'noAsistencia',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> noAsistenciaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'noAsistencia',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> noAsistenciaEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'noAsistencia',
        value: value,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> noAsistenciaGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'noAsistencia',
        value: value,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> noAsistenciaLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'noAsistencia',
        value: value,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> noAsistenciaBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'noAsistencia',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> obligatorioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'obligatorio',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> obligatorioIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'obligatorio',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> obligatorioEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'obligatorio',
        value: value,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> obligatorioGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'obligatorio',
        value: value,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> obligatorioLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'obligatorio',
        value: value,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> obligatorioBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'obligatorio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> ordenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'orden',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> ordenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'orden',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> ordenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orden',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> ordenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'orden',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> ordenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'orden',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> ordenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'orden',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> ordenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'orden',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> ordenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'orden',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> ordenContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'orden',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> ordenMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'orden',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> ordenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orden',
        value: '',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> ordenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'orden',
        value: '',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> preguntasIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'preguntas',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> preguntasIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'preguntas',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> preguntasLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'preguntas',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> preguntasIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'preguntas',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> preguntasIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'preguntas',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> preguntasLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'preguntas',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> preguntasLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'preguntas',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> preguntasLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'preguntas',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> puntajeTotalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'puntajeTotal',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> puntajeTotalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'puntajeTotal',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> puntajeTotalEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'puntajeTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> puntajeTotalGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'puntajeTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> puntajeTotalLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'puntajeTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> puntajeTotalBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'puntajeTotal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> sondeoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sondeo',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> sondeoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sondeo',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> sondeoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sondeo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> sondeoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sondeo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> sondeoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sondeo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> sondeoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sondeo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> sondeoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sondeo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> sondeoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sondeo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> sondeoContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sondeo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> sondeoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sondeo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> sondeoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sondeo',
        value: '',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> sondeoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sondeo',
        value: '',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> tareaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tarea',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> tareaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tarea',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> tareaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tarea',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> tareaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tarea',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> tareaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tarea',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> tareaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tarea',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> tareaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tarea',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> tareaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tarea',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> tareaContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tarea',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> tareaMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tarea',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> tareaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tarea',
        value: '',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> tareaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tarea',
        value: '',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> uuidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'uuid',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> uuidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'uuid',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> uuidEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> uuidGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> uuidLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> uuidBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> uuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> uuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> uuidContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> uuidMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<RespM, RespM, QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension RespMQueryObject on QueryBuilder<RespM, RespM, QFilterCondition> {
  QueryBuilder<RespM, RespM, QAfterFilterCondition> preguntasElement(
      FilterQuery<Preguntas> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'preguntas');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const PreguntasSchema = Schema(
  name: r'Preguntas',
  id: 6339261212767773140,
  properties: {
    r'capturaNTiempos': PropertySchema(
      id: 0,
      name: r'capturaNTiempos',
      type: IsarType.long,
    ),
    r'dependePregunta': PropertySchema(
      id: 1,
      name: r'dependePregunta',
      type: IsarType.string,
    ),
    r'dependeRespuesta': PropertySchema(
      id: 2,
      name: r'dependeRespuesta',
      type: IsarType.string,
    ),
    r'fotoGaleria': PropertySchema(
      id: 3,
      name: r'fotoGaleria',
      type: IsarType.long,
    ),
    r'fotoGuardarCopia': PropertySchema(
      id: 4,
      name: r'fotoGuardarCopia',
      type: IsarType.long,
    ),
    r'id': PropertySchema(
      id: 5,
      name: r'id',
      type: IsarType.string,
    ),
    r'idIniciativa': PropertySchema(
      id: 6,
      name: r'idIniciativa',
      type: IsarType.string,
    ),
    r'idPreguntaRespuesta': PropertySchema(
      id: 7,
      name: r'idPreguntaRespuesta',
      type: IsarType.string,
    ),
    r'idTienda': PropertySchema(
      id: 8,
      name: r'idTienda',
      type: IsarType.string,
    ),
    r'obligatorio': PropertySchema(
      id: 9,
      name: r'obligatorio',
      type: IsarType.long,
    ),
    r'opciones': PropertySchema(
      id: 10,
      name: r'opciones',
      type: IsarType.objectList,
      target: r'Opciones',
    ),
    r'ordenI': PropertySchema(
      id: 11,
      name: r'ordenI',
      type: IsarType.string,
    ),
    r'pregunta': PropertySchema(
      id: 12,
      name: r'pregunta',
      type: IsarType.string,
    ),
    r'puntaje': PropertySchema(
      id: 13,
      name: r'puntaje',
      type: IsarType.double,
    ),
    r'respuesta': PropertySchema(
      id: 14,
      name: r'respuesta',
      type: IsarType.string,
    ),
    r'tipo': PropertySchema(
      id: 15,
      name: r'tipo',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(
      id: 16,
      name: r'uuid',
      type: IsarType.string,
    ),
    r'valorMaximo': PropertySchema(
      id: 17,
      name: r'valorMaximo',
      type: IsarType.double,
    ),
    r'valorMinimo': PropertySchema(
      id: 18,
      name: r'valorMinimo',
      type: IsarType.double,
    )
  },
  estimateSize: _preguntasEstimateSize,
  serialize: _preguntasSerialize,
  deserialize: _preguntasDeserialize,
  deserializeProp: _preguntasDeserializeProp,
);

int _preguntasEstimateSize(
  Preguntas object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.dependePregunta;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.dependeRespuesta;
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
    final value = object.idIniciativa;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.idPreguntaRespuesta;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.idTienda;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.opciones;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[Opciones]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += OpcionesSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.ordenI;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.pregunta;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.respuesta;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.tipo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.uuid;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _preguntasSerialize(
  Preguntas object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.capturaNTiempos);
  writer.writeString(offsets[1], object.dependePregunta);
  writer.writeString(offsets[2], object.dependeRespuesta);
  writer.writeLong(offsets[3], object.fotoGaleria);
  writer.writeLong(offsets[4], object.fotoGuardarCopia);
  writer.writeString(offsets[5], object.id);
  writer.writeString(offsets[6], object.idIniciativa);
  writer.writeString(offsets[7], object.idPreguntaRespuesta);
  writer.writeString(offsets[8], object.idTienda);
  writer.writeLong(offsets[9], object.obligatorio);
  writer.writeObjectList<Opciones>(
    offsets[10],
    allOffsets,
    OpcionesSchema.serialize,
    object.opciones,
  );
  writer.writeString(offsets[11], object.ordenI);
  writer.writeString(offsets[12], object.pregunta);
  writer.writeDouble(offsets[13], object.puntaje);
  writer.writeString(offsets[14], object.respuesta);
  writer.writeString(offsets[15], object.tipo);
  writer.writeString(offsets[16], object.uuid);
  writer.writeDouble(offsets[17], object.valorMaximo);
  writer.writeDouble(offsets[18], object.valorMinimo);
}

Preguntas _preguntasDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Preguntas(
    capturaNTiempos: reader.readLongOrNull(offsets[0]),
    dependePregunta: reader.readStringOrNull(offsets[1]),
    dependeRespuesta: reader.readStringOrNull(offsets[2]),
    fotoGaleria: reader.readLongOrNull(offsets[3]),
    fotoGuardarCopia: reader.readLongOrNull(offsets[4]),
    id: reader.readStringOrNull(offsets[5]),
    idIniciativa: reader.readStringOrNull(offsets[6]),
    idPreguntaRespuesta: reader.readStringOrNull(offsets[7]),
    idTienda: reader.readStringOrNull(offsets[8]),
    obligatorio: reader.readLongOrNull(offsets[9]),
    opciones: reader.readObjectList<Opciones>(
      offsets[10],
      OpcionesSchema.deserialize,
      allOffsets,
      Opciones(),
    ),
    ordenI: reader.readStringOrNull(offsets[11]),
    pregunta: reader.readStringOrNull(offsets[12]),
    puntaje: reader.readDoubleOrNull(offsets[13]),
    respuesta: reader.readStringOrNull(offsets[14]),
    tipo: reader.readStringOrNull(offsets[15]),
    uuid: reader.readStringOrNull(offsets[16]),
    valorMaximo: reader.readDoubleOrNull(offsets[17]),
    valorMinimo: reader.readDoubleOrNull(offsets[18]),
  );
  return object;
}

P _preguntasDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    case 10:
      return (reader.readObjectList<Opciones>(
        offset,
        OpcionesSchema.deserialize,
        allOffsets,
        Opciones(),
      )) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readDoubleOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readDoubleOrNull(offset)) as P;
    case 18:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension PreguntasQueryFilter
    on QueryBuilder<Preguntas, Preguntas, QFilterCondition> {
  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      capturaNTiemposIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'capturaNTiempos',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      capturaNTiemposIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'capturaNTiempos',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      capturaNTiemposEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'capturaNTiempos',
        value: value,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      capturaNTiemposGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'capturaNTiempos',
        value: value,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      capturaNTiemposLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'capturaNTiempos',
        value: value,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      capturaNTiemposBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'capturaNTiempos',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      dependePreguntaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dependePregunta',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      dependePreguntaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dependePregunta',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      dependePreguntaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dependePregunta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      dependePreguntaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dependePregunta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      dependePreguntaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dependePregunta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      dependePreguntaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dependePregunta',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      dependePreguntaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dependePregunta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      dependePreguntaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dependePregunta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      dependePreguntaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dependePregunta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      dependePreguntaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dependePregunta',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      dependePreguntaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dependePregunta',
        value: '',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      dependePreguntaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dependePregunta',
        value: '',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      dependeRespuestaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dependeRespuesta',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      dependeRespuestaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dependeRespuesta',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      dependeRespuestaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dependeRespuesta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      dependeRespuestaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dependeRespuesta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      dependeRespuestaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dependeRespuesta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      dependeRespuestaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dependeRespuesta',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      dependeRespuestaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dependeRespuesta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      dependeRespuestaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dependeRespuesta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      dependeRespuestaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dependeRespuesta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      dependeRespuestaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dependeRespuesta',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      dependeRespuestaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dependeRespuesta',
        value: '',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      dependeRespuestaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dependeRespuesta',
        value: '',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      fotoGaleriaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fotoGaleria',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      fotoGaleriaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fotoGaleria',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> fotoGaleriaEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fotoGaleria',
        value: value,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      fotoGaleriaGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fotoGaleria',
        value: value,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> fotoGaleriaLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fotoGaleria',
        value: value,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> fotoGaleriaBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fotoGaleria',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      fotoGuardarCopiaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fotoGuardarCopia',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      fotoGuardarCopiaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fotoGuardarCopia',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      fotoGuardarCopiaEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fotoGuardarCopia',
        value: value,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      fotoGuardarCopiaGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fotoGuardarCopia',
        value: value,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      fotoGuardarCopiaLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fotoGuardarCopia',
        value: value,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      fotoGuardarCopiaBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fotoGuardarCopia',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> idContains(
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

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> idMatches(
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

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      idIniciativaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'idIniciativa',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      idIniciativaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'idIniciativa',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> idIniciativaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idIniciativa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      idIniciativaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idIniciativa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      idIniciativaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idIniciativa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> idIniciativaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idIniciativa',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      idIniciativaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'idIniciativa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      idIniciativaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'idIniciativa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      idIniciativaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'idIniciativa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> idIniciativaMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'idIniciativa',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      idIniciativaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idIniciativa',
        value: '',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      idIniciativaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'idIniciativa',
        value: '',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      idPreguntaRespuestaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'idPreguntaRespuesta',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      idPreguntaRespuestaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'idPreguntaRespuesta',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      idPreguntaRespuestaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idPreguntaRespuesta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      idPreguntaRespuestaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idPreguntaRespuesta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      idPreguntaRespuestaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idPreguntaRespuesta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      idPreguntaRespuestaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idPreguntaRespuesta',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      idPreguntaRespuestaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'idPreguntaRespuesta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      idPreguntaRespuestaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'idPreguntaRespuesta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      idPreguntaRespuestaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'idPreguntaRespuesta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      idPreguntaRespuestaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'idPreguntaRespuesta',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      idPreguntaRespuestaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idPreguntaRespuesta',
        value: '',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      idPreguntaRespuestaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'idPreguntaRespuesta',
        value: '',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> idTiendaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'idTienda',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      idTiendaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'idTienda',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> idTiendaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idTienda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> idTiendaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idTienda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> idTiendaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idTienda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> idTiendaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idTienda',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> idTiendaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'idTienda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> idTiendaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'idTienda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> idTiendaContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'idTienda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> idTiendaMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'idTienda',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> idTiendaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idTienda',
        value: '',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      idTiendaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'idTienda',
        value: '',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      obligatorioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'obligatorio',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      obligatorioIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'obligatorio',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> obligatorioEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'obligatorio',
        value: value,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      obligatorioGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'obligatorio',
        value: value,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> obligatorioLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'obligatorio',
        value: value,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> obligatorioBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'obligatorio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> opcionesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'opciones',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      opcionesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'opciones',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      opcionesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'opciones',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> opcionesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'opciones',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      opcionesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'opciones',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      opcionesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'opciones',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      opcionesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'opciones',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      opcionesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'opciones',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> ordenIIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ordenI',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> ordenIIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ordenI',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> ordenIEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ordenI',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> ordenIGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ordenI',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> ordenILessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ordenI',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> ordenIBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ordenI',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> ordenIStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ordenI',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> ordenIEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ordenI',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> ordenIContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ordenI',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> ordenIMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ordenI',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> ordenIIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ordenI',
        value: '',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> ordenIIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ordenI',
        value: '',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> preguntaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pregunta',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      preguntaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pregunta',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> preguntaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pregunta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> preguntaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pregunta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> preguntaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pregunta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> preguntaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pregunta',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> preguntaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pregunta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> preguntaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pregunta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> preguntaContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pregunta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> preguntaMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pregunta',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> preguntaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pregunta',
        value: '',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      preguntaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pregunta',
        value: '',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> puntajeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'puntaje',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> puntajeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'puntaje',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> puntajeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'puntaje',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> puntajeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'puntaje',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> puntajeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'puntaje',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> puntajeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'puntaje',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> respuestaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'respuesta',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      respuestaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'respuesta',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> respuestaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'respuesta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      respuestaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'respuesta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> respuestaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'respuesta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> respuestaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'respuesta',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> respuestaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'respuesta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> respuestaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'respuesta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> respuestaContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'respuesta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> respuestaMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'respuesta',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> respuestaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'respuesta',
        value: '',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      respuestaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'respuesta',
        value: '',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> tipoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tipo',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> tipoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tipo',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> tipoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> tipoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> tipoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> tipoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tipo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> tipoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> tipoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> tipoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> tipoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tipo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> tipoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipo',
        value: '',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> tipoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipo',
        value: '',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> uuidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'uuid',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> uuidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'uuid',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> uuidEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> uuidGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> uuidLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> uuidBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> uuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> uuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> uuidContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> uuidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      valorMaximoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'valorMaximo',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      valorMaximoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'valorMaximo',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> valorMaximoEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valorMaximo',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      valorMaximoGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'valorMaximo',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> valorMaximoLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'valorMaximo',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> valorMaximoBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'valorMaximo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      valorMinimoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'valorMinimo',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      valorMinimoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'valorMinimo',
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> valorMinimoEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valorMinimo',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition>
      valorMinimoGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'valorMinimo',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> valorMinimoLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'valorMinimo',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> valorMinimoBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'valorMinimo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension PreguntasQueryObject
    on QueryBuilder<Preguntas, Preguntas, QFilterCondition> {
  QueryBuilder<Preguntas, Preguntas, QAfterFilterCondition> opcionesElement(
      FilterQuery<Opciones> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'opciones');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const OpcionesSchema = Schema(
  name: r'Opciones',
  id: 1344956677032613553,
  properties: {
    r'id': PropertySchema(
      id: 0,
      name: r'id',
      type: IsarType.string,
    ),
    r'opcion': PropertySchema(
      id: 1,
      name: r'opcion',
      type: IsarType.string,
    ),
    r'puntos': PropertySchema(
      id: 2,
      name: r'puntos',
      type: IsarType.double,
    )
  },
  estimateSize: _opcionesEstimateSize,
  serialize: _opcionesSerialize,
  deserialize: _opcionesDeserialize,
  deserializeProp: _opcionesDeserializeProp,
);

int _opcionesEstimateSize(
  Opciones object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.id;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.opcion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _opcionesSerialize(
  Opciones object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.id);
  writer.writeString(offsets[1], object.opcion);
  writer.writeDouble(offsets[2], object.puntos);
}

Opciones _opcionesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Opciones(
    id: reader.readStringOrNull(offsets[0]),
    opcion: reader.readStringOrNull(offsets[1]),
    puntos: reader.readDoubleOrNull(offsets[2]),
  );
  return object;
}

P _opcionesDeserializeProp<P>(
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
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension OpcionesQueryFilter
    on QueryBuilder<Opciones, Opciones, QFilterCondition> {
  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> idContains(
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

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> idMatches(
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

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> opcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'opcion',
      ));
    });
  }

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> opcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'opcion',
      ));
    });
  }

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> opcionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'opcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> opcionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'opcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> opcionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'opcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> opcionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'opcion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> opcionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'opcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> opcionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'opcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> opcionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'opcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> opcionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'opcion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> opcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'opcion',
        value: '',
      ));
    });
  }

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> opcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'opcion',
        value: '',
      ));
    });
  }

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> puntosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'puntos',
      ));
    });
  }

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> puntosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'puntos',
      ));
    });
  }

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> puntosEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'puntos',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> puntosGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'puntos',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> puntosLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'puntos',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Opciones, Opciones, QAfterFilterCondition> puntosBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'puntos',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension OpcionesQueryObject
    on QueryBuilder<Opciones, Opciones, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const Store2Schema = Schema(
  name: r'Store2',
  id: -934016287618768098,
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
  estimateSize: _store2EstimateSize,
  serialize: _store2Serialize,
  deserialize: _store2Deserialize,
  deserializeProp: _store2DeserializeProp,
);

int _store2EstimateSize(
  Store2 object,
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

void _store2Serialize(
  Store2 object,
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

Store2 _store2Deserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Store2(
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
  return object;
}

P _store2DeserializeProp<P>(
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

extension Store2QueryFilter on QueryBuilder<Store2, Store2, QFilterCondition> {
  QueryBuilder<Store2, Store2, QAfterFilterCondition> checkGPSIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'checkGPS',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> checkGPSIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'checkGPS',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> checkGPSEqualTo(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> checkGPSGreaterThan(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> checkGPSLessThan(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> checkGPSBetween(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> checkGPSStartsWith(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> checkGPSEndsWith(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> checkGPSContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'checkGPS',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> checkGPSMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'checkGPS',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> checkGPSIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'checkGPS',
        value: '',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> checkGPSIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'checkGPS',
        value: '',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> clasificacionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'clasificacion',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> clasificacionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'clasificacion',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> clasificacionEqualTo(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> clasificacionGreaterThan(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> clasificacionLessThan(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> clasificacionBetween(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> clasificacionStartsWith(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> clasificacionEndsWith(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> clasificacionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clasificacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> clasificacionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clasificacion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> clasificacionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clasificacion',
        value: '',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition>
      clasificacionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clasificacion',
        value: '',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> definirNombreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'definirNombre',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> definirNombreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'definirNombre',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> definirNombreEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'definirNombre',
        value: value,
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> definirNombreGreaterThan(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> definirNombreLessThan(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> definirNombreBetween(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idCadenaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'idCadena',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idCadenaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'idCadena',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idCadenaEqualTo(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idCadenaGreaterThan(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idCadenaLessThan(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idCadenaBetween(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idCadenaStartsWith(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idCadenaEndsWith(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idCadenaContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'idCadena',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idCadenaMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'idCadena',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idCadenaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idCadena',
        value: '',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idCadenaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'idCadena',
        value: '',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idGrupoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'idGrupo',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idGrupoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'idGrupo',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idGrupoEqualTo(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idGrupoGreaterThan(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idGrupoLessThan(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idGrupoBetween(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idGrupoStartsWith(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idGrupoEndsWith(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idGrupoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'idGrupo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idGrupoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'idGrupo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idGrupoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idGrupo',
        value: '',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> idGrupoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'idGrupo',
        value: '',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> latitudIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'latitud',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> latitudIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'latitud',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> latitudEqualTo(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> latitudGreaterThan(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> latitudLessThan(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> latitudBetween(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> longitudIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'longitud',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> longitudIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'longitud',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> longitudEqualTo(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> longitudGreaterThan(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> longitudLessThan(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> longitudBetween(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> rangoGPSIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rangoGPS',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> rangoGPSIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rangoGPS',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> rangoGPSEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rangoGPS',
        value: value,
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> rangoGPSGreaterThan(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> rangoGPSLessThan(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> rangoGPSBetween(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> tiendaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tienda',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> tiendaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tienda',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> tiendaEqualTo(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> tiendaGreaterThan(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> tiendaLessThan(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> tiendaBetween(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> tiendaStartsWith(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> tiendaEndsWith(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> tiendaContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tienda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> tiendaMatches(
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

  QueryBuilder<Store2, Store2, QAfterFilterCondition> tiendaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tienda',
        value: '',
      ));
    });
  }

  QueryBuilder<Store2, Store2, QAfterFilterCondition> tiendaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tienda',
        value: '',
      ));
    });
  }
}

extension Store2QueryObject on QueryBuilder<Store2, Store2, QFilterCondition> {}
