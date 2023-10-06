// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stores.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStoreIsarCollection on Isar {
  IsarCollection<StoreIsar> get storeIsars => this.collection();
}

const StoreIsarSchema = CollectionSchema(
  name: r'StoreIsar',
  id: 861575192000619861,
  properties: {
    r'currentQuestion': PropertySchema(
      id: 0,
      name: r'currentQuestion',
      type: IsarType.long,
    ),
    r'progress': PropertySchema(
      id: 1,
      name: r'progress',
      type: IsarType.double,
    ),
    r'responsesQuestions': PropertySchema(
      id: 2,
      name: r'responsesQuestions',
      type: IsarType.stringList,
    ),
    r'responsesSelectionList': PropertySchema(
      id: 3,
      name: r'responsesSelectionList',
      type: IsarType.stringList,
    ),
    r'store': PropertySchema(
      id: 4,
      name: r'store',
      type: IsarType.object,
      target: r'Store',
    ),
    r'totalQuestions': PropertySchema(
      id: 5,
      name: r'totalQuestions',
      type: IsarType.long,
    )
  },
  estimateSize: _storeIsarEstimateSize,
  serialize: _storeIsarSerialize,
  deserialize: _storeIsarDeserialize,
  deserializeProp: _storeIsarDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'Store': StoreSchema},
  getId: _storeIsarGetId,
  getLinks: _storeIsarGetLinks,
  attach: _storeIsarAttach,
  version: '3.1.0+1',
);

int _storeIsarEstimateSize(
  StoreIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.responsesQuestions;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final list = object.responsesSelectionList;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final value = object.store;
    if (value != null) {
      bytesCount +=
          3 + StoreSchema.estimateSize(value, allOffsets[Store]!, allOffsets);
    }
  }
  return bytesCount;
}

void _storeIsarSerialize(
  StoreIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.currentQuestion);
  writer.writeDouble(offsets[1], object.progress);
  writer.writeStringList(offsets[2], object.responsesQuestions);
  writer.writeStringList(offsets[3], object.responsesSelectionList);
  writer.writeObject<Store>(
    offsets[4],
    allOffsets,
    StoreSchema.serialize,
    object.store,
  );
  writer.writeLong(offsets[5], object.totalQuestions);
}

StoreIsar _storeIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StoreIsar(
    currentQuestion: reader.readLongOrNull(offsets[0]),
    progress: reader.readDoubleOrNull(offsets[1]),
    responsesQuestions: reader.readStringList(offsets[2]),
    responsesSelectionList: reader.readStringList(offsets[3]),
    store: reader.readObjectOrNull<Store>(
      offsets[4],
      StoreSchema.deserialize,
      allOffsets,
    ),
    totalQuestions: reader.readLongOrNull(offsets[5]),
  );
  object.id = id;
  return object;
}

P _storeIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readStringList(offset)) as P;
    case 3:
      return (reader.readStringList(offset)) as P;
    case 4:
      return (reader.readObjectOrNull<Store>(
        offset,
        StoreSchema.deserialize,
        allOffsets,
      )) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _storeIsarGetId(StoreIsar object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _storeIsarGetLinks(StoreIsar object) {
  return [];
}

void _storeIsarAttach(IsarCollection<dynamic> col, Id id, StoreIsar object) {
  object.id = id;
}

extension StoreIsarQueryWhereSort
    on QueryBuilder<StoreIsar, StoreIsar, QWhere> {
  QueryBuilder<StoreIsar, StoreIsar, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension StoreIsarQueryWhere
    on QueryBuilder<StoreIsar, StoreIsar, QWhereClause> {
  QueryBuilder<StoreIsar, StoreIsar, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<StoreIsar, StoreIsar, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterWhereClause> idBetween(
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

extension StoreIsarQueryFilter
    on QueryBuilder<StoreIsar, StoreIsar, QFilterCondition> {
  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      currentQuestionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'currentQuestion',
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      currentQuestionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'currentQuestion',
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      currentQuestionEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentQuestion',
        value: value,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      currentQuestionGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentQuestion',
        value: value,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      currentQuestionLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentQuestion',
        value: value,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      currentQuestionBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentQuestion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition> idBetween(
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

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition> progressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'progress',
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      progressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'progress',
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition> progressEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'progress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition> progressGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'progress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition> progressLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'progress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition> progressBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'progress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesQuestionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'responsesQuestions',
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesQuestionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'responsesQuestions',
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesQuestionsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'responsesQuestions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesQuestionsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'responsesQuestions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesQuestionsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'responsesQuestions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesQuestionsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'responsesQuestions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesQuestionsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'responsesQuestions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesQuestionsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'responsesQuestions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesQuestionsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'responsesQuestions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesQuestionsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'responsesQuestions',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesQuestionsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'responsesQuestions',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesQuestionsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'responsesQuestions',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesQuestionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'responsesQuestions',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesQuestionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'responsesQuestions',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesQuestionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'responsesQuestions',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesQuestionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'responsesQuestions',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesQuestionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'responsesQuestions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesQuestionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'responsesQuestions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesSelectionListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'responsesSelectionList',
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesSelectionListIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'responsesSelectionList',
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesSelectionListElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'responsesSelectionList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesSelectionListElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'responsesSelectionList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesSelectionListElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'responsesSelectionList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesSelectionListElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'responsesSelectionList',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesSelectionListElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'responsesSelectionList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesSelectionListElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'responsesSelectionList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesSelectionListElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'responsesSelectionList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesSelectionListElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'responsesSelectionList',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesSelectionListElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'responsesSelectionList',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesSelectionListElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'responsesSelectionList',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesSelectionListLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'responsesSelectionList',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesSelectionListIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'responsesSelectionList',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesSelectionListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'responsesSelectionList',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesSelectionListLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'responsesSelectionList',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesSelectionListLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'responsesSelectionList',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      responsesSelectionListLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'responsesSelectionList',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition> storeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'store',
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition> storeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'store',
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      totalQuestionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'totalQuestions',
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      totalQuestionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'totalQuestions',
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      totalQuestionsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalQuestions',
        value: value,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      totalQuestionsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalQuestions',
        value: value,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      totalQuestionsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalQuestions',
        value: value,
      ));
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition>
      totalQuestionsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalQuestions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension StoreIsarQueryObject
    on QueryBuilder<StoreIsar, StoreIsar, QFilterCondition> {
  QueryBuilder<StoreIsar, StoreIsar, QAfterFilterCondition> store(
      FilterQuery<Store> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'store');
    });
  }
}

extension StoreIsarQueryLinks
    on QueryBuilder<StoreIsar, StoreIsar, QFilterCondition> {}

extension StoreIsarQuerySortBy on QueryBuilder<StoreIsar, StoreIsar, QSortBy> {
  QueryBuilder<StoreIsar, StoreIsar, QAfterSortBy> sortByCurrentQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentQuestion', Sort.asc);
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterSortBy> sortByCurrentQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentQuestion', Sort.desc);
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterSortBy> sortByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.asc);
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterSortBy> sortByProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.desc);
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterSortBy> sortByTotalQuestions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalQuestions', Sort.asc);
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterSortBy> sortByTotalQuestionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalQuestions', Sort.desc);
    });
  }
}

extension StoreIsarQuerySortThenBy
    on QueryBuilder<StoreIsar, StoreIsar, QSortThenBy> {
  QueryBuilder<StoreIsar, StoreIsar, QAfterSortBy> thenByCurrentQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentQuestion', Sort.asc);
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterSortBy> thenByCurrentQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentQuestion', Sort.desc);
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterSortBy> thenByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.asc);
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterSortBy> thenByProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.desc);
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterSortBy> thenByTotalQuestions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalQuestions', Sort.asc);
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QAfterSortBy> thenByTotalQuestionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalQuestions', Sort.desc);
    });
  }
}

extension StoreIsarQueryWhereDistinct
    on QueryBuilder<StoreIsar, StoreIsar, QDistinct> {
  QueryBuilder<StoreIsar, StoreIsar, QDistinct> distinctByCurrentQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentQuestion');
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QDistinct> distinctByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'progress');
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QDistinct> distinctByResponsesQuestions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'responsesQuestions');
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QDistinct>
      distinctByResponsesSelectionList() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'responsesSelectionList');
    });
  }

  QueryBuilder<StoreIsar, StoreIsar, QDistinct> distinctByTotalQuestions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalQuestions');
    });
  }
}

extension StoreIsarQueryProperty
    on QueryBuilder<StoreIsar, StoreIsar, QQueryProperty> {
  QueryBuilder<StoreIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<StoreIsar, int?, QQueryOperations> currentQuestionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentQuestion');
    });
  }

  QueryBuilder<StoreIsar, double?, QQueryOperations> progressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'progress');
    });
  }

  QueryBuilder<StoreIsar, List<String>?, QQueryOperations>
      responsesQuestionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'responsesQuestions');
    });
  }

  QueryBuilder<StoreIsar, List<String>?, QQueryOperations>
      responsesSelectionListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'responsesSelectionList');
    });
  }

  QueryBuilder<StoreIsar, Store?, QQueryOperations> storeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'store');
    });
  }

  QueryBuilder<StoreIsar, int?, QQueryOperations> totalQuestionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalQuestions');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const StoreSchema = Schema(
  name: r'Store',
  id: 6037299533961794238,
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
  estimateSize: _storeEstimateSize,
  serialize: _storeSerialize,
  deserialize: _storeDeserialize,
  deserializeProp: _storeDeserializeProp,
);

int _storeEstimateSize(
  Store object,
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

void _storeSerialize(
  Store object,
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

Store _storeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Store(
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

P _storeDeserializeProp<P>(
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

extension StoreQueryFilter on QueryBuilder<Store, Store, QFilterCondition> {
  QueryBuilder<Store, Store, QAfterFilterCondition> checkGPSIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'checkGPS',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> checkGPSIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'checkGPS',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> checkGPSEqualTo(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> checkGPSGreaterThan(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> checkGPSLessThan(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> checkGPSBetween(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> checkGPSStartsWith(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> checkGPSEndsWith(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> checkGPSContains(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> checkGPSMatches(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> checkGPSIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'checkGPS',
        value: '',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> checkGPSIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'checkGPS',
        value: '',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> clasificacionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'clasificacion',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> clasificacionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'clasificacion',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> clasificacionEqualTo(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> clasificacionGreaterThan(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> clasificacionLessThan(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> clasificacionBetween(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> clasificacionStartsWith(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> clasificacionEndsWith(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> clasificacionContains(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> clasificacionMatches(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> clasificacionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clasificacion',
        value: '',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> clasificacionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clasificacion',
        value: '',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> definirNombreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'definirNombre',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> definirNombreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'definirNombre',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> definirNombreEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'definirNombre',
        value: value,
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> definirNombreGreaterThan(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> definirNombreLessThan(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> definirNombreBetween(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> idCadenaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'idCadena',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> idCadenaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'idCadena',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> idCadenaEqualTo(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> idCadenaGreaterThan(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> idCadenaLessThan(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> idCadenaBetween(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> idCadenaStartsWith(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> idCadenaEndsWith(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> idCadenaContains(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> idCadenaMatches(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> idCadenaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idCadena',
        value: '',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> idCadenaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'idCadena',
        value: '',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> idGrupoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'idGrupo',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> idGrupoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'idGrupo',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> idGrupoEqualTo(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> idGrupoGreaterThan(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> idGrupoLessThan(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> idGrupoBetween(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> idGrupoStartsWith(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> idGrupoEndsWith(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> idGrupoContains(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> idGrupoMatches(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> idGrupoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idGrupo',
        value: '',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> idGrupoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'idGrupo',
        value: '',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> latitudIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'latitud',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> latitudIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'latitud',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> latitudEqualTo(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> latitudGreaterThan(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> latitudLessThan(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> latitudBetween(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> longitudIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'longitud',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> longitudIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'longitud',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> longitudEqualTo(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> longitudGreaterThan(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> longitudLessThan(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> longitudBetween(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> rangoGPSIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rangoGPS',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> rangoGPSIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rangoGPS',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> rangoGPSEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rangoGPS',
        value: value,
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> rangoGPSGreaterThan(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> rangoGPSLessThan(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> rangoGPSBetween(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> tiendaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tienda',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> tiendaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tienda',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> tiendaEqualTo(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> tiendaGreaterThan(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> tiendaLessThan(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> tiendaBetween(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> tiendaStartsWith(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> tiendaEndsWith(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> tiendaContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tienda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> tiendaMatches(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> tiendaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tienda',
        value: '',
      ));
    });
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> tiendaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tienda',
        value: '',
      ));
    });
  }
}

extension StoreQueryObject on QueryBuilder<Store, Store, QFilterCondition> {}
