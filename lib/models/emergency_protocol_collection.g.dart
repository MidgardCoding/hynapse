// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_protocol_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types, experimental_member_use

extension GetEmergencyProtocolCollectionCollection on Isar {
  IsarCollection<EmergencyProtocolCollection>
  get emergencyProtocolCollections => this.collection();
}

const EmergencyProtocolCollectionSchema = CollectionSchema(
  name: r'EmergencyProtocolCollection',
  id: -3879453998861975553,
  properties: {
    r'category': PropertySchema(
      id: 0,
      name: r'category',
      type: IsarType.string,
    ),
    r'categoryLabel': PropertySchema(
      id: 1,
      name: r'categoryLabel',
      type: IsarType.string,
    ),
    r'instructions': PropertySchema(
      id: 2,
      name: r'instructions',
      type: IsarType.stringList,
    ),
    r'isCritical': PropertySchema(
      id: 3,
      name: r'isCritical',
      type: IsarType.bool,
    ),
    r'sosActive': PropertySchema(
      id: 4,
      name: r'sosActive',
      type: IsarType.bool,
    ),
    r'summary': PropertySchema(id: 5, name: r'summary', type: IsarType.string),
    r'title': PropertySchema(id: 6, name: r'title', type: IsarType.string),
  },

  estimateSize: _emergencyProtocolCollectionEstimateSize,
  serialize: _emergencyProtocolCollectionSerialize,
  deserialize: _emergencyProtocolCollectionDeserialize,
  deserializeProp: _emergencyProtocolCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'category': IndexSchema(
      id: -7560358558326323820,
      name: r'category',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'category',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'title': IndexSchema(
      id: -7636685945352118059,
      name: r'title',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'title',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _emergencyProtocolCollectionGetId,
  getLinks: _emergencyProtocolCollectionGetLinks,
  attach: _emergencyProtocolCollectionAttach,
  version: '3.4.1',
);

int _emergencyProtocolCollectionEstimateSize(
  EmergencyProtocolCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.category.length * 3;
  bytesCount += 3 + object.categoryLabel.length * 3;
  bytesCount += 3 + object.instructions.length * 3;
  {
    for (var i = 0; i < object.instructions.length; i++) {
      final value = object.instructions[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.summary.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _emergencyProtocolCollectionSerialize(
  EmergencyProtocolCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.category);
  writer.writeString(offsets[1], object.categoryLabel);
  writer.writeStringList(offsets[2], object.instructions);
  writer.writeBool(offsets[3], object.isCritical);
  writer.writeBool(offsets[4], object.sosActive);
  writer.writeString(offsets[5], object.summary);
  writer.writeString(offsets[6], object.title);
}

EmergencyProtocolCollection _emergencyProtocolCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EmergencyProtocolCollection();
  object.category = reader.readString(offsets[0]);
  object.id = id;
  object.instructions = reader.readStringList(offsets[2]) ?? [];
  object.isCritical = reader.readBool(offsets[3]);
  object.sosActive = reader.readBool(offsets[4]);
  object.summary = reader.readString(offsets[5]);
  object.title = reader.readString(offsets[6]);
  return object;
}

P _emergencyProtocolCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringList(offset) ?? []) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _emergencyProtocolCollectionGetId(EmergencyProtocolCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _emergencyProtocolCollectionGetLinks(
  EmergencyProtocolCollection object,
) {
  return [];
}

void _emergencyProtocolCollectionAttach(
  IsarCollection<dynamic> col,
  Id id,
  EmergencyProtocolCollection object,
) {
  object.id = id;
}

extension EmergencyProtocolCollectionQueryWhereSort
    on
        QueryBuilder<
          EmergencyProtocolCollection,
          EmergencyProtocolCollection,
          QWhere
        > {
  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterWhere
  >
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EmergencyProtocolCollectionQueryWhere
    on
        QueryBuilder<
          EmergencyProtocolCollection,
          EmergencyProtocolCollection,
          QWhereClause
        > {
  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterWhereClause
  >
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
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
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
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
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
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
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
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
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterWhereClause
  >
  categoryEqualTo(String category) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'category', value: [category]),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterWhereClause
  >
  categoryNotEqualTo(String category) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'category',
                lower: [],
                upper: [category],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'category',
                lower: [category],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'category',
                lower: [category],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'category',
                lower: [],
                upper: [category],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterWhereClause
  >
  titleEqualTo(String title) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'title', value: [title]),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterWhereClause
  >
  titleNotEqualTo(String title) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'title',
                lower: [],
                upper: [title],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'title',
                lower: [title],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'title',
                lower: [title],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'title',
                lower: [],
                upper: [title],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension EmergencyProtocolCollectionQueryFilter
    on
        QueryBuilder<
          EmergencyProtocolCollection,
          EmergencyProtocolCollection,
          QFilterCondition
        > {
  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  categoryEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  categoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  categoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  categoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'category',
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
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  categoryStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  categoryEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'category',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'category', value: ''),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'category', value: ''),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  categoryLabelEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'categoryLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  categoryLabelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'categoryLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  categoryLabelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'categoryLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  categoryLabelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'categoryLabel',
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
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  categoryLabelStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'categoryLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  categoryLabelEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'categoryLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  categoryLabelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'categoryLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  categoryLabelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'categoryLabel',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  categoryLabelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'categoryLabel', value: ''),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  categoryLabelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'categoryLabel', value: ''),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
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
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
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
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
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
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
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
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  instructionsElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'instructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  instructionsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'instructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  instructionsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'instructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  instructionsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'instructions',
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
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  instructionsElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'instructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  instructionsElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'instructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  instructionsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'instructions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  instructionsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'instructions',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  instructionsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'instructions', value: ''),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  instructionsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'instructions', value: ''),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  instructionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'instructions', length, true, length, true);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  instructionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'instructions', 0, true, 0, true);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  instructionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'instructions', 0, false, 999999, true);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  instructionsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'instructions', 0, true, length, include);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  instructionsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'instructions', length, include, 999999, true);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  instructionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'instructions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  isCriticalEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isCritical', value: value),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  sosActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sosActive', value: value),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  summaryEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'summary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  summaryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'summary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  summaryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'summary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  summaryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'summary',
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
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  summaryStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'summary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  summaryEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'summary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  summaryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'summary',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  summaryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'summary',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  summaryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'summary', value: ''),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  summaryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'summary', value: ''),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  titleEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'title',
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
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  titleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  titleEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'title',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'title', value: ''),
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterFilterCondition
  >
  titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'title', value: ''),
      );
    });
  }
}

extension EmergencyProtocolCollectionQueryObject
    on
        QueryBuilder<
          EmergencyProtocolCollection,
          EmergencyProtocolCollection,
          QFilterCondition
        > {}

extension EmergencyProtocolCollectionQueryLinks
    on
        QueryBuilder<
          EmergencyProtocolCollection,
          EmergencyProtocolCollection,
          QFilterCondition
        > {}

extension EmergencyProtocolCollectionQuerySortBy
    on
        QueryBuilder<
          EmergencyProtocolCollection,
          EmergencyProtocolCollection,
          QSortBy
        > {
  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  sortByCategoryLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryLabel', Sort.asc);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  sortByCategoryLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryLabel', Sort.desc);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  sortByIsCritical() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCritical', Sort.asc);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  sortByIsCriticalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCritical', Sort.desc);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  sortBySosActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sosActive', Sort.asc);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  sortBySosActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sosActive', Sort.desc);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  sortBySummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.asc);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  sortBySummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.desc);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension EmergencyProtocolCollectionQuerySortThenBy
    on
        QueryBuilder<
          EmergencyProtocolCollection,
          EmergencyProtocolCollection,
          QSortThenBy
        > {
  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  thenByCategoryLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryLabel', Sort.asc);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  thenByCategoryLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryLabel', Sort.desc);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  thenByIsCritical() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCritical', Sort.asc);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  thenByIsCriticalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCritical', Sort.desc);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  thenBySosActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sosActive', Sort.asc);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  thenBySosActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sosActive', Sort.desc);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  thenBySummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.asc);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  thenBySummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.desc);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QAfterSortBy
  >
  thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension EmergencyProtocolCollectionQueryWhereDistinct
    on
        QueryBuilder<
          EmergencyProtocolCollection,
          EmergencyProtocolCollection,
          QDistinct
        > {
  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QDistinct
  >
  distinctByCategory({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QDistinct
  >
  distinctByCategoryLabel({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'categoryLabel',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QDistinct
  >
  distinctByInstructions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'instructions');
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QDistinct
  >
  distinctByIsCritical() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCritical');
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QDistinct
  >
  distinctBySosActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sosActive');
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QDistinct
  >
  distinctBySummary({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'summary', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<
    EmergencyProtocolCollection,
    EmergencyProtocolCollection,
    QDistinct
  >
  distinctByTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension EmergencyProtocolCollectionQueryProperty
    on
        QueryBuilder<
          EmergencyProtocolCollection,
          EmergencyProtocolCollection,
          QQueryProperty
        > {
  QueryBuilder<EmergencyProtocolCollection, int, QQueryOperations>
  idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<EmergencyProtocolCollection, String, QQueryOperations>
  categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<EmergencyProtocolCollection, String, QQueryOperations>
  categoryLabelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoryLabel');
    });
  }

  QueryBuilder<EmergencyProtocolCollection, List<String>, QQueryOperations>
  instructionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'instructions');
    });
  }

  QueryBuilder<EmergencyProtocolCollection, bool, QQueryOperations>
  isCriticalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCritical');
    });
  }

  QueryBuilder<EmergencyProtocolCollection, bool, QQueryOperations>
  sosActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sosActive');
    });
  }

  QueryBuilder<EmergencyProtocolCollection, String, QQueryOperations>
  summaryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'summary');
    });
  }

  QueryBuilder<EmergencyProtocolCollection, String, QQueryOperations>
  titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
