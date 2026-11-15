// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_log_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types, experimental_member_use

extension GetDailyLogCollectionCollection on Isar {
  IsarCollection<DailyLogCollection> get dailyLogCollections =>
      this.collection();
}

const DailyLogCollectionSchema = CollectionSchema(
  name: r'DailyLogCollection',
  id: -1741759339579345821,
  properties: {
    r'fatigue': PropertySchema(id: 0, name: r'fatigue', type: IsarType.long),
    r'readiness': PropertySchema(
      id: 1,
      name: r'readiness',
      type: IsarType.long,
    ),
    r'sleepDeprivation': PropertySchema(
      id: 2,
      name: r'sleepDeprivation',
      type: IsarType.long,
    ),
    r'speechClarity': PropertySchema(
      id: 3,
      name: r'speechClarity',
      type: IsarType.long,
    ),
    r'stress': PropertySchema(id: 4, name: r'stress', type: IsarType.long),
    r'timestamp': PropertySchema(
      id: 5,
      name: r'timestamp',
      type: IsarType.dateTime,
    ),
    r'timestampLabel': PropertySchema(
      id: 6,
      name: r'timestampLabel',
      type: IsarType.string,
    ),
    r'transcript': PropertySchema(
      id: 7,
      name: r'transcript',
      type: IsarType.string,
    ),
    r'userId': PropertySchema(id: 8, name: r'userId', type: IsarType.string),
  },

  estimateSize: _dailyLogCollectionEstimateSize,
  serialize: _dailyLogCollectionSerialize,
  deserialize: _dailyLogCollectionDeserialize,
  deserializeProp: _dailyLogCollectionDeserializeProp,
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

  getId: _dailyLogCollectionGetId,
  getLinks: _dailyLogCollectionGetLinks,
  attach: _dailyLogCollectionAttach,
  version: '3.4.1',
);

int _dailyLogCollectionEstimateSize(
  DailyLogCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.timestampLabel.length * 3;
  bytesCount += 3 + object.transcript.length * 3;
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _dailyLogCollectionSerialize(
  DailyLogCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.fatigue);
  writer.writeLong(offsets[1], object.readiness);
  writer.writeLong(offsets[2], object.sleepDeprivation);
  writer.writeLong(offsets[3], object.speechClarity);
  writer.writeLong(offsets[4], object.stress);
  writer.writeDateTime(offsets[5], object.timestamp);
  writer.writeString(offsets[6], object.timestampLabel);
  writer.writeString(offsets[7], object.transcript);
  writer.writeString(offsets[8], object.userId);
}

DailyLogCollection _dailyLogCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DailyLogCollection();
  object.fatigue = reader.readLong(offsets[0]);
  object.id = id;
  object.readiness = reader.readLong(offsets[1]);
  object.sleepDeprivation = reader.readLong(offsets[2]);
  object.speechClarity = reader.readLong(offsets[3]);
  object.stress = reader.readLong(offsets[4]);
  object.timestamp = reader.readDateTime(offsets[5]);
  object.transcript = reader.readString(offsets[7]);
  object.userId = reader.readString(offsets[8]);
  return object;
}

P _dailyLogCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dailyLogCollectionGetId(DailyLogCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dailyLogCollectionGetLinks(
  DailyLogCollection object,
) {
  return [];
}

void _dailyLogCollectionAttach(
  IsarCollection<dynamic> col,
  Id id,
  DailyLogCollection object,
) {
  object.id = id;
}

extension DailyLogCollectionQueryWhereSort
    on QueryBuilder<DailyLogCollection, DailyLogCollection, QWhere> {
  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterWhere>
  anyTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'timestamp'),
      );
    });
  }
}

extension DailyLogCollectionQueryWhere
    on QueryBuilder<DailyLogCollection, DailyLogCollection, QWhereClause> {
  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterWhereClause>
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

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterWhereClause>
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

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterWhereClause>
  userIdEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'userId', value: [userId]),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterWhereClause>
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

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterWhereClause>
  timestampEqualTo(DateTime timestamp) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'timestamp', value: [timestamp]),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterWhereClause>
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

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterWhereClause>
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

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterWhereClause>
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

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterWhereClause>
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

extension DailyLogCollectionQueryFilter
    on QueryBuilder<DailyLogCollection, DailyLogCollection, QFilterCondition> {
  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  fatigueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fatigue', value: value),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  fatigueGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fatigue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  fatigueLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fatigue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  fatigueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fatigue',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
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

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
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

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
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

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  readinessEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'readiness', value: value),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  readinessGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'readiness',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  readinessLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'readiness',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  readinessBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'readiness',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  sleepDeprivationEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sleepDeprivation', value: value),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  sleepDeprivationGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sleepDeprivation',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  sleepDeprivationLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sleepDeprivation',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  sleepDeprivationBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sleepDeprivation',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  speechClarityEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'speechClarity', value: value),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  speechClarityGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'speechClarity',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  speechClarityLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'speechClarity',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  speechClarityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'speechClarity',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  stressEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'stress', value: value),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  stressGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'stress',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  stressLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'stress',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  stressBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'stress',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'timestamp', value: value),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
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

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
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

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
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

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  timestampLabelEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'timestampLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  timestampLabelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'timestampLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  timestampLabelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'timestampLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  timestampLabelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'timestampLabel',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  timestampLabelStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'timestampLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  timestampLabelEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'timestampLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  timestampLabelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'timestampLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  timestampLabelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'timestampLabel',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  timestampLabelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'timestampLabel', value: ''),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  timestampLabelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'timestampLabel', value: ''),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  transcriptEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'transcript',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  transcriptGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'transcript',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  transcriptLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'transcript',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  transcriptBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'transcript',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  transcriptStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'transcript',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  transcriptEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'transcript',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  transcriptContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'transcript',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  transcriptMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'transcript',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  transcriptIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'transcript', value: ''),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  transcriptIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'transcript', value: ''),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
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

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
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

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
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

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
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

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
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

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
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

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
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

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
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

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'userId', value: ''),
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterFilterCondition>
  userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'userId', value: ''),
      );
    });
  }
}

extension DailyLogCollectionQueryObject
    on QueryBuilder<DailyLogCollection, DailyLogCollection, QFilterCondition> {}

extension DailyLogCollectionQueryLinks
    on QueryBuilder<DailyLogCollection, DailyLogCollection, QFilterCondition> {}

extension DailyLogCollectionQuerySortBy
    on QueryBuilder<DailyLogCollection, DailyLogCollection, QSortBy> {
  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  sortByFatigue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatigue', Sort.asc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  sortByFatigueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatigue', Sort.desc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  sortByReadiness() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readiness', Sort.asc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  sortByReadinessDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readiness', Sort.desc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  sortBySleepDeprivation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sleepDeprivation', Sort.asc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  sortBySleepDeprivationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sleepDeprivation', Sort.desc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  sortBySpeechClarity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speechClarity', Sort.asc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  sortBySpeechClarityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speechClarity', Sort.desc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  sortByStress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stress', Sort.asc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  sortByStressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stress', Sort.desc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  sortByTimestampLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestampLabel', Sort.asc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  sortByTimestampLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestampLabel', Sort.desc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  sortByTranscript() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transcript', Sort.asc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  sortByTranscriptDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transcript', Sort.desc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension DailyLogCollectionQuerySortThenBy
    on QueryBuilder<DailyLogCollection, DailyLogCollection, QSortThenBy> {
  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  thenByFatigue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatigue', Sort.asc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  thenByFatigueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatigue', Sort.desc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  thenByReadiness() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readiness', Sort.asc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  thenByReadinessDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readiness', Sort.desc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  thenBySleepDeprivation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sleepDeprivation', Sort.asc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  thenBySleepDeprivationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sleepDeprivation', Sort.desc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  thenBySpeechClarity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speechClarity', Sort.asc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  thenBySpeechClarityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speechClarity', Sort.desc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  thenByStress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stress', Sort.asc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  thenByStressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stress', Sort.desc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  thenByTimestampLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestampLabel', Sort.asc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  thenByTimestampLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestampLabel', Sort.desc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  thenByTranscript() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transcript', Sort.asc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  thenByTranscriptDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transcript', Sort.desc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QAfterSortBy>
  thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension DailyLogCollectionQueryWhereDistinct
    on QueryBuilder<DailyLogCollection, DailyLogCollection, QDistinct> {
  QueryBuilder<DailyLogCollection, DailyLogCollection, QDistinct>
  distinctByFatigue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fatigue');
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QDistinct>
  distinctByReadiness() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'readiness');
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QDistinct>
  distinctBySleepDeprivation() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sleepDeprivation');
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QDistinct>
  distinctBySpeechClarity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'speechClarity');
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QDistinct>
  distinctByStress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stress');
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QDistinct>
  distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QDistinct>
  distinctByTimestampLabel({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'timestampLabel',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QDistinct>
  distinctByTranscript({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transcript', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DailyLogCollection, DailyLogCollection, QDistinct>
  distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension DailyLogCollectionQueryProperty
    on QueryBuilder<DailyLogCollection, DailyLogCollection, QQueryProperty> {
  QueryBuilder<DailyLogCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DailyLogCollection, int, QQueryOperations> fatigueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fatigue');
    });
  }

  QueryBuilder<DailyLogCollection, int, QQueryOperations> readinessProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'readiness');
    });
  }

  QueryBuilder<DailyLogCollection, int, QQueryOperations>
  sleepDeprivationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sleepDeprivation');
    });
  }

  QueryBuilder<DailyLogCollection, int, QQueryOperations>
  speechClarityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'speechClarity');
    });
  }

  QueryBuilder<DailyLogCollection, int, QQueryOperations> stressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stress');
    });
  }

  QueryBuilder<DailyLogCollection, DateTime, QQueryOperations>
  timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }

  QueryBuilder<DailyLogCollection, String, QQueryOperations>
  timestampLabelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestampLabel');
    });
  }

  QueryBuilder<DailyLogCollection, String, QQueryOperations>
  transcriptProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transcript');
    });
  }

  QueryBuilder<DailyLogCollection, String, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
