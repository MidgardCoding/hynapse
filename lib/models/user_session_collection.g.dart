// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_session_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types, experimental_member_use

extension GetUserSessionCollectionCollection on Isar {
  IsarCollection<UserSessionCollection> get userSessionCollections =>
      this.collection();
}

const UserSessionCollectionSchema = CollectionSchema(
  name: r'UserSessionCollection',
  id: 6386831575292742819,
  properties: {
    r'displayName': PropertySchema(
      id: 0,
      name: r'displayName',
      type: IsarType.string,
    ),
    r'isAuthorized': PropertySchema(
      id: 1,
      name: r'isAuthorized',
      type: IsarType.bool,
    ),
    r'lastSync': PropertySchema(
      id: 2,
      name: r'lastSync',
      type: IsarType.dateTime,
    ),
    r'lastSynchronization': PropertySchema(
      id: 3,
      name: r'lastSynchronization',
      type: IsarType.dateTime,
    ),
    r'role': PropertySchema(id: 4, name: r'role', type: IsarType.string),
    r'userId': PropertySchema(id: 5, name: r'userId', type: IsarType.string),
  },

  estimateSize: _userSessionCollectionEstimateSize,
  serialize: _userSessionCollectionSerialize,
  deserialize: _userSessionCollectionDeserialize,
  deserializeProp: _userSessionCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'userId': IndexSchema(
      id: -2005826577402374815,
      name: r'userId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _userSessionCollectionGetId,
  getLinks: _userSessionCollectionGetLinks,
  attach: _userSessionCollectionAttach,
  version: '3.4.1',
);

int _userSessionCollectionEstimateSize(
  UserSessionCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.displayName.length * 3;
  bytesCount += 3 + object.role.length * 3;
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _userSessionCollectionSerialize(
  UserSessionCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.displayName);
  writer.writeBool(offsets[1], object.isAuthorized);
  writer.writeDateTime(offsets[2], object.lastSync);
  writer.writeDateTime(offsets[3], object.lastSynchronization);
  writer.writeString(offsets[4], object.role);
  writer.writeString(offsets[5], object.userId);
}

UserSessionCollection _userSessionCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserSessionCollection();
  object.displayName = reader.readString(offsets[0]);
  object.id = id;
  object.isAuthorized = reader.readBool(offsets[1]);
  object.lastSync = reader.readDateTime(offsets[2]);
  object.role = reader.readString(offsets[4]);
  object.userId = reader.readString(offsets[5]);
  return object;
}

P _userSessionCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userSessionCollectionGetId(UserSessionCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userSessionCollectionGetLinks(
  UserSessionCollection object,
) {
  return [];
}

void _userSessionCollectionAttach(
  IsarCollection<dynamic> col,
  Id id,
  UserSessionCollection object,
) {
  object.id = id;
}

extension UserSessionCollectionByIndex
    on IsarCollection<UserSessionCollection> {
  Future<UserSessionCollection?> getByUserId(String userId) {
    return getByIndex(r'userId', [userId]);
  }

  UserSessionCollection? getByUserIdSync(String userId) {
    return getByIndexSync(r'userId', [userId]);
  }

  Future<bool> deleteByUserId(String userId) {
    return deleteByIndex(r'userId', [userId]);
  }

  bool deleteByUserIdSync(String userId) {
    return deleteByIndexSync(r'userId', [userId]);
  }

  Future<List<UserSessionCollection?>> getAllByUserId(
    List<String> userIdValues,
  ) {
    final values = userIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'userId', values);
  }

  List<UserSessionCollection?> getAllByUserIdSync(List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'userId', values);
  }

  Future<int> deleteAllByUserId(List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'userId', values);
  }

  int deleteAllByUserIdSync(List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'userId', values);
  }

  Future<Id> putByUserId(UserSessionCollection object) {
    return putByIndex(r'userId', object);
  }

  Id putByUserIdSync(UserSessionCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'userId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUserId(List<UserSessionCollection> objects) {
    return putAllByIndex(r'userId', objects);
  }

  List<Id> putAllByUserIdSync(
    List<UserSessionCollection> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'userId', objects, saveLinks: saveLinks);
  }
}

extension UserSessionCollectionQueryWhereSort
    on QueryBuilder<UserSessionCollection, UserSessionCollection, QWhere> {
  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserSessionCollectionQueryWhere
    on
        QueryBuilder<
          UserSessionCollection,
          UserSessionCollection,
          QWhereClause
        > {
  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterWhereClause>
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

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterWhereClause>
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

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterWhereClause>
  userIdEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'userId', value: [userId]),
      );
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterWhereClause>
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
}

extension UserSessionCollectionQueryFilter
    on
        QueryBuilder<
          UserSessionCollection,
          UserSessionCollection,
          QFilterCondition
        > {
  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  displayNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'displayName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  displayNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'displayName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  displayNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'displayName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  displayNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'displayName',
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
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  displayNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'displayName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  displayNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'displayName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  displayNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'displayName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  displayNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'displayName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  displayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'displayName', value: ''),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  displayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'displayName', value: ''),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
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
    UserSessionCollection,
    UserSessionCollection,
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
    UserSessionCollection,
    UserSessionCollection,
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
    UserSessionCollection,
    UserSessionCollection,
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
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  isAuthorizedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isAuthorized', value: value),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  lastSyncEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastSync', value: value),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  lastSyncGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastSync',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  lastSyncLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastSync',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  lastSyncBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastSync',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  lastSynchronizationEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastSynchronization', value: value),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  lastSynchronizationGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastSynchronization',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  lastSynchronizationLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastSynchronization',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  lastSynchronizationBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastSynchronization',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  roleEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'role',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  roleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'role',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  roleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'role',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  roleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'role',
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
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  roleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'role',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  roleEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'role',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  roleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'role',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  roleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'role',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  roleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'role', value: ''),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
    QAfterFilterCondition
  >
  roleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'role', value: ''),
      );
    });
  }

  QueryBuilder<
    UserSessionCollection,
    UserSessionCollection,
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
    UserSessionCollection,
    UserSessionCollection,
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
    UserSessionCollection,
    UserSessionCollection,
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
    UserSessionCollection,
    UserSessionCollection,
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
    UserSessionCollection,
    UserSessionCollection,
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
    UserSessionCollection,
    UserSessionCollection,
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
    UserSessionCollection,
    UserSessionCollection,
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
    UserSessionCollection,
    UserSessionCollection,
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
    UserSessionCollection,
    UserSessionCollection,
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
    UserSessionCollection,
    UserSessionCollection,
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

extension UserSessionCollectionQueryObject
    on
        QueryBuilder<
          UserSessionCollection,
          UserSessionCollection,
          QFilterCondition
        > {}

extension UserSessionCollectionQueryLinks
    on
        QueryBuilder<
          UserSessionCollection,
          UserSessionCollection,
          QFilterCondition
        > {}

extension UserSessionCollectionQuerySortBy
    on QueryBuilder<UserSessionCollection, UserSessionCollection, QSortBy> {
  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  sortByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  sortByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  sortByIsAuthorized() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAuthorized', Sort.asc);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  sortByIsAuthorizedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAuthorized', Sort.desc);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  sortByLastSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSync', Sort.asc);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  sortByLastSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSync', Sort.desc);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  sortByLastSynchronization() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSynchronization', Sort.asc);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  sortByLastSynchronizationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSynchronization', Sort.desc);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  sortByRole() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'role', Sort.asc);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  sortByRoleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'role', Sort.desc);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension UserSessionCollectionQuerySortThenBy
    on QueryBuilder<UserSessionCollection, UserSessionCollection, QSortThenBy> {
  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  thenByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  thenByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  thenByIsAuthorized() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAuthorized', Sort.asc);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  thenByIsAuthorizedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAuthorized', Sort.desc);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  thenByLastSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSync', Sort.asc);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  thenByLastSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSync', Sort.desc);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  thenByLastSynchronization() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSynchronization', Sort.asc);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  thenByLastSynchronizationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSynchronization', Sort.desc);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  thenByRole() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'role', Sort.asc);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  thenByRoleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'role', Sort.desc);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QAfterSortBy>
  thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension UserSessionCollectionQueryWhereDistinct
    on QueryBuilder<UserSessionCollection, UserSessionCollection, QDistinct> {
  QueryBuilder<UserSessionCollection, UserSessionCollection, QDistinct>
  distinctByDisplayName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QDistinct>
  distinctByIsAuthorized() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isAuthorized');
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QDistinct>
  distinctByLastSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastSync');
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QDistinct>
  distinctByLastSynchronization() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastSynchronization');
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QDistinct>
  distinctByRole({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'role', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserSessionCollection, UserSessionCollection, QDistinct>
  distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension UserSessionCollectionQueryProperty
    on
        QueryBuilder<
          UserSessionCollection,
          UserSessionCollection,
          QQueryProperty
        > {
  QueryBuilder<UserSessionCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserSessionCollection, String, QQueryOperations>
  displayNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayName');
    });
  }

  QueryBuilder<UserSessionCollection, bool, QQueryOperations>
  isAuthorizedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isAuthorized');
    });
  }

  QueryBuilder<UserSessionCollection, DateTime, QQueryOperations>
  lastSyncProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSync');
    });
  }

  QueryBuilder<UserSessionCollection, DateTime, QQueryOperations>
  lastSynchronizationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSynchronization');
    });
  }

  QueryBuilder<UserSessionCollection, String, QQueryOperations> roleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'role');
    });
  }

  QueryBuilder<UserSessionCollection, String, QQueryOperations>
  userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
