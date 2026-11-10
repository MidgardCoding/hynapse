import 'package:isar_community/isar.dart';

import '../models/cognitive_test_result_collection.dart';
import '../models/daily_log_collection.dart';
import '../models/emergency_protocol_collection.dart';
import '../models/user_session_collection.dart';
import 'isar_service.dart';

class HynapseRepository {
  HynapseRepository(this._service);

  final IsarService _service;

  Isar get _db => _service.db;

  Future<UserSessionCollection?> currentSession() {
    return _db.userSessionCollections
        .filter()
        .isAuthorizedEqualTo(true)
        .sortByLastSyncDesc()
        .findFirst();
  }

  Future<UserSessionCollection> signIn({
    required String userId,
    required String displayName,
  }) async {
    final session = UserSessionCollection()
      ..userId = userId
      ..displayName = displayName
      ..isAuthorized = true
      ..role = 'astronaut'
      ..lastSync = DateTime.now();

    await _db.writeTxn(() => _db.userSessionCollections.put(session));
    return session;
  }

  Future<void> signOut(UserSessionCollection session) async {
    session.isAuthorized = false;
    session.lastSync = DateTime.now();
    await _db.writeTxn(() => _db.userSessionCollections.put(session));
  }

  Future<void> markSynchronized(UserSessionCollection session) async {
    session.lastSync = DateTime.now();
    await _db.writeTxn(() => _db.userSessionCollections.put(session));
  }

  Future<void> saveDailyLog(DailyLogCollection log) async {
    await _db.writeTxn(() => _db.dailyLogCollections.put(log));
  }

  Future<DailyLogCollection?> latestDailyLog({String? userId}) async {
    final query = _db.dailyLogCollections.where();
    if (userId != null) {
      return query
          .filter()
          .userIdEqualTo(userId)
          .sortByTimestampDesc()
          .findFirst();
    }
    return query.sortByTimestampDesc().findFirst();
  }

  Future<List<DailyLogCollection>> recentDailyLogs({int limit = 14}) {
    return _db.dailyLogCollections
        .where()
        .sortByTimestampDesc()
        .limit(limit)
        .findAll();
  }

  Future<void> saveCognitiveResult(CognitiveTestResultCollection result) async {
    await _db.writeTxn(() => _db.cognitiveTestResultCollections.put(result));
  }

  Future<List<CognitiveTestResultCollection>> resultsForType(
    String testType, {
    int limit = 20,
  }) {
    return _db.cognitiveTestResultCollections
        .filter()
        .testTypeEqualTo(testType)
        .sortByTimestampDesc()
        .limit(limit)
        .findAll();
  }

  Future<List<CognitiveTestResultCollection>> recentResults({int limit = 30}) {
    return _db.cognitiveTestResultCollections
        .where()
        .sortByTimestampDesc()
        .limit(limit)
        .findAll();
  }

  Future<List<EmergencyProtocolCollection>> emergencyProtocols() {
    return _db.emergencyProtocolCollections.where().sortByTitle().findAll();
  }

  Future<EmergencyProtocolCollection?> protocolByTitle(String title) async {
    return _db.emergencyProtocolCollections
        .filter()
        .titleEqualTo(title)
        .findFirst();
  }

  Future<void> saveProtocol(EmergencyProtocolCollection protocol) async {
    await _db.writeTxn(() => _db.emergencyProtocolCollections.put(protocol));
  }

  Future<bool> setSosStatus(
    EmergencyProtocolCollection protocol,
    bool active,
  ) async {
    protocol.sosActive = active;
    await _db.writeTxn(() => _db.emergencyProtocolCollections.put(protocol));
    return active;
  }

  Future<int> dailyLogCount() => _db.dailyLogCollections.count();
  Future<int> testCount() => _db.cognitiveTestResultCollections.count();

  Future<List<DailyLogCollection>> allDailyLogs() {
    return _db.dailyLogCollections.where().sortByTimestampDesc().findAll();
  }

  Future<List<CognitiveTestResultCollection>> allResults() {
    return _db.cognitiveTestResultCollections
        .where()
        .sortByTimestampDesc()
        .findAll();
  }
}
