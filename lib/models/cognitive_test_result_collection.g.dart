// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cognitive_test_result_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types, experimental_member_use

extension GetCognitiveTestResultCollectionCollection on Isar {
  IsarCollection<CognitiveTestResultCollection>
  get cognitiveTestResultCollections => this.collection();
}

const CognitiveTestResultCollectionSchema = CollectionSchema(
  name: r'CognitiveTestResultCollection',
  id: -2320324500146929743,
  properties: {
    r'averageReactionTimeMs': PropertySchema(
      id: 0,
      name: r'averageReactionTimeMs',
      type: IsarType.double,
    ),
    r'correctCount': PropertySchema(
      id: 1,
      name: r'correctCount',
      type: IsarType.long,
    ),
    r'incorrectCount': PropertySchema(
      id: 2,
      name: r'incorrectCount',
      type: IsarType.long,
    ),
    r'testLabel': PropertySchema(
      id: 3,
      name: r'testLabel',
      type: IsarType.string,
    ),
    r'testType': PropertySchema(
      id: 4,
      name: r'testType',
      type: IsarType.string,
    ),
    r'timestamp': PropertySchema(
      id: 5,
      name: r'timestamp',
      type: IsarType.dateTime,
    ),
    r'userId': PropertySchema(id: 6, name: r'userId', type: IsarType.string),
  },

  estimateSize: _cognitiveTestResultCollectionEstimateSize,
  serialize: _cognitiveTestResultCollectionSerialize,
  deserialize: _cognitiveTestResultCollectionDeserialize,
  deserializeProp: _cognitiveTestResultCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'userId': IndexSchema(
      id: -2005826577402374815,
      name: r'userId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'testType': IndexSchema(
      id: -1676870248283008756,
      name: r'testType',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'testType',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'timestamp': IndexSchema(
      id: 1852253767416892198,
      name: r'timestamp',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'timestamp',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _cognitiveTestResultCollectionGetId,
  getLinks: _cognitiveTestResultCollectionGetLinks,
  attach: _cognitiveTestResultCollectionAttach,
  version: '3.4.1',
);

int _cognitiveTestResultCollectionEstimateSize(
  CognitiveTestResultCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.testLabel.length * 3;
  bytesCount += 3 + object.testType.length * 3;
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _cognitiveTestResultCollectionSerialize(
  CognitiveTestResultCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.averageReactionTimeMs);
  writer.writeLong(offsets[1], object.correctCount);
  writer.writeLong(offsets[2], object.incorrectCount);
  writer.writeString(offsets[3], object.testLabel);
  writer.writeString(offsets[4], object.testType);
  writer.writeDateTime(offsets[5], object.timestamp);
  writer.writeString(offsets[6], object.userId);
}

CognitiveTestResultCollection _cognitiveTestResultCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CognitiveTestResultCollection();
  object.averageReactionTimeMs = reader.readDouble(offsets[0]);
  object.correctCount = reader.readLong(offsets[1]);
  object.id = id;
  object.incorrectCount = reader.readLong(offsets[2]);
  object.testType = reader.readString(offsets[4]);
  object.timestamp = reader.readDateTime(offsets[5]);
  object.userId = reader.readString(offsets[6]);
  return object;
}

P _cognitiveTestResultCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cognitiveTestResultCollectionGetId(CognitiveTestResultCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cognitiveTestResultCollectionGetLinks(
  CognitiveTestResultCollection object,
) {
  return [];
}

void _cognitiveTestResultCollectionAttach(
  IsarCollection<dynamic> col,
  Id id,
  CognitiveTestResultCollection object,
) {
  object.id = id;
}

extension CognitiveTestResultCollectionQueryWhereSort
    on
        QueryBuilder<
          CognitiveTestResultCollection,
          CognitiveTestResultCollection,
          QWhere
        > {
  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterWhere
  >
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterWhere
  >
  anyTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'timestamp'),
      );
    });
  }
}

extension CognitiveTestResultCollectionQueryWhere
    on
        QueryBuilder<
          CognitiveTestResultCollection,
          CognitiveTestResultCollection,
          QWhereClause
        > {
  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterWhereClause
  >
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterWhereClause
  >
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

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterWhereClause
  >
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterWhereClause
  >
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterWhereClause
  >
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterWhereClause
  >
  userIdEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'userId', value: [userId]),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterWhereClause
  >
  userIdNotEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'userId',
                lower: [],
                upper: [userId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'userId',
                lower: [userId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'userId',
                lower: [userId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'userId',
                lower: [],
                upper: [userId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterWhereClause
  >
  testTypeEqualTo(String testType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'testType', value: [testType]),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterWhereClause
  >
  testTypeNotEqualTo(String testType) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'testType',
                lower: [],
                upper: [testType],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'testType',
                lower: [testType],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'testType',
                lower: [testType],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'testType',
                lower: [],
                upper: [testType],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterWhereClause
  >
  timestampEqualTo(DateTime timestamp) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'timestamp', value: [timestamp]),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterWhereClause
  >
  timestampNotEqualTo(DateTime timestamp) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'timestamp',
                lower: [],
                upper: [timestamp],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'timestamp',
                lower: [timestamp],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'timestamp',
                lower: [timestamp],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'timestamp',
                lower: [],
                upper: [timestamp],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterWhereClause
  >
  timestampGreaterThan(DateTime timestamp, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'timestamp',
          lower: [timestamp],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterWhereClause
  >
  timestampLessThan(DateTime timestamp, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'timestamp',
          lower: [],
          upper: [timestamp],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterWhereClause
  >
  timestampBetween(
    DateTime lowerTimestamp,
    DateTime upperTimestamp, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'timestamp',
          lower: [lowerTimestamp],
          includeLower: includeLower,
          upper: [upperTimestamp],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension CognitiveTestResultCollectionQueryFilter
    on
        QueryBuilder<
          CognitiveTestResultCollection,
          CognitiveTestResultCollection,
          QFilterCondition
        > {
  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  averageReactionTimeMsEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'averageReactionTimeMs',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  averageReactionTimeMsGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'averageReactionTimeMs',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  averageReactionTimeMsLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'averageReactionTimeMs',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  averageReactionTimeMsBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'averageReactionTimeMs',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  correctCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'correctCount', value: value),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  correctCountGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'correctCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  correctCountLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'correctCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  correctCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'correctCount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  incorrectCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'incorrectCount', value: value),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  incorrectCountGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'incorrectCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  incorrectCountLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'incorrectCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  incorrectCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'incorrectCount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  testLabelEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'testLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  testLabelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'testLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  testLabelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'testLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  testLabelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'testLabel',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  testLabelStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'testLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  testLabelEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'testLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  testLabelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'testLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  testLabelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'testLabel',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  testLabelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'testLabel', value: ''),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  testLabelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'testLabel', value: ''),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  testTypeEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'testType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  testTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'testType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  testTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'testType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  testTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'testType',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  testTypeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'testType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  testTypeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'testType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  testTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'testType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  testTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'testType',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  testTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'testType', value: ''),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  testTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'testType', value: ''),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'timestamp', value: value),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  timestampGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'timestamp',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  timestampLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'timestamp',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'timestamp',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  userIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'userId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  userIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  userIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'userId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'userId', value: ''),
      );
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterFilterCondition
  >
  userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'userId', value: ''),
      );
    });
  }
}

extension CognitiveTestResultCollectionQueryObject
    on
        QueryBuilder<
          CognitiveTestResultCollection,
          CognitiveTestResultCollection,
          QFilterCondition
        > {}

extension CognitiveTestResultCollectionQueryLinks
    on
        QueryBuilder<
          CognitiveTestResultCollection,
          CognitiveTestResultCollection,
          QFilterCondition
        > {}

extension CognitiveTestResultCollectionQuerySortBy
    on
        QueryBuilder<
          CognitiveTestResultCollection,
          CognitiveTestResultCollection,
          QSortBy
        > {
  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  sortByAverageReactionTimeMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageReactionTimeMs', Sort.asc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  sortByAverageReactionTimeMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageReactionTimeMs', Sort.desc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  sortByCorrectCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctCount', Sort.asc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  sortByCorrectCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctCount', Sort.desc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  sortByIncorrectCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'incorrectCount', Sort.asc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  sortByIncorrectCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'incorrectCount', Sort.desc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  sortByTestLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'testLabel', Sort.asc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  sortByTestLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'testLabel', Sort.desc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  sortByTestType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'testType', Sort.asc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  sortByTestTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'testType', Sort.desc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension CognitiveTestResultCollectionQuerySortThenBy
    on
        QueryBuilder<
          CognitiveTestResultCollection,
          CognitiveTestResultCollection,
          QSortThenBy
        > {
  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  thenByAverageReactionTimeMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageReactionTimeMs', Sort.asc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  thenByAverageReactionTimeMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageReactionTimeMs', Sort.desc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  thenByCorrectCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctCount', Sort.asc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  thenByCorrectCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctCount', Sort.desc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  thenByIncorrectCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'incorrectCount', Sort.asc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  thenByIncorrectCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'incorrectCount', Sort.desc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  thenByTestLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'testLabel', Sort.asc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  thenByTestLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'testLabel', Sort.desc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  thenByTestType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'testType', Sort.asc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  thenByTestTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'testType', Sort.desc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QAfterSortBy
  >
  thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension CognitiveTestResultCollectionQueryWhereDistinct
    on
        QueryBuilder<
          CognitiveTestResultCollection,
          CognitiveTestResultCollection,
          QDistinct
        > {
  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QDistinct
  >
  distinctByAverageReactionTimeMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'averageReactionTimeMs');
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QDistinct
  >
  distinctByCorrectCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'correctCount');
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QDistinct
  >
  distinctByIncorrectCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'incorrectCount');
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QDistinct
  >
  distinctByTestLabel({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'testLabel', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QDistinct
  >
  distinctByTestType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'testType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QDistinct
  >
  distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }

  QueryBuilder<
    CognitiveTestResultCollection,
    CognitiveTestResultCollection,
    QDistinct
  >
  distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension CognitiveTestResultCollectionQueryProperty
    on
        QueryBuilder<
          CognitiveTestResultCollection,
          CognitiveTestResultCollection,
          QQueryProperty
        > {
  QueryBuilder<CognitiveTestResultCollection, int, QQueryOperations>
  idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CognitiveTestResultCollection, double, QQueryOperations>
  averageReactionTimeMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'averageReactionTimeMs');
    });
  }

  QueryBuilder<CognitiveTestResultCollection, int, QQueryOperations>
  correctCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'correctCount');
    });
  }

  QueryBuilder<CognitiveTestResultCollection, int, QQueryOperations>
  incorrectCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'incorrectCount');
    });
  }

  QueryBuilder<CognitiveTestResultCollection, String, QQueryOperations>
  testLabelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'testLabel');
    });
  }

  QueryBuilder<CognitiveTestResultCollection, String, QQueryOperations>
  testTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'testType');
    });
  }

  QueryBuilder<CognitiveTestResultCollection, DateTime, QQueryOperations>
  timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }

  QueryBuilder<CognitiveTestResultCollection, String, QQueryOperations>
  userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
