import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';

import '../models/cognitive_test_result_collection.dart';
import '../models/daily_log_collection.dart';
import '../models/emergency_protocol_collection.dart';
import '../models/user_session_collection.dart';
import '../services/auth_service.dart';
import '../services/hynapse_repository.dart';
import '../services/isar_service.dart';
import '../services/voice_analysis_service.dart';

final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError('Isar must be overridden in ProviderScope.');
});

final isarServiceProvider = Provider<IsarService>((ref) {
  return IsarService(ref.watch(isarProvider));
});

final repositoryProvider = Provider<HynapseRepository>((ref) {
  return HynapseRepository(ref.watch(isarServiceProvider));
});

final authServiceProvider = Provider<AuthService>((ref) => AuthService());
final voiceAnalysisProvider =
    Provider<VoiceAnalysisService>((ref) => const VoiceAnalysisService());

class SessionController extends StateNotifier<AsyncValue<UserSessionCollection?>> {
  SessionController(this._repository) : super(const AsyncValue.loading()) {
    reload();
  }

  final HynapseRepository _repository;

  Future<void> reload() async {
    state = const AsyncValue.loading();
    try {
      final session = await _repository.currentSession();
      state = AsyncValue.data(session);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<UserSessionCollection> authorize({
    required String userId,
    required String displayName,
  }) async {
    final session = await _repository.signIn(
      userId: userId,
      displayName: displayName,
    );
    state = AsyncValue.data(session);
    return session;
  }

  Future<void> synchronize() async {
    final session = state.valueOrNull;
    if (session == null) return;
    await _repository.markSynchronized(session);
    state = AsyncValue.data(session);
  }

  Future<void> signOut() async {
    final session = state.valueOrNull;
    if (session != null) {
      await _repository.signOut(session);
    }
    state = const AsyncValue.data(null);
  }
}

final sessionProvider =
    StateNotifierProvider<SessionController, AsyncValue<UserSessionCollection?>>(
  (ref) => SessionController(ref.watch(repositoryProvider)),
);

class TodaySummary {
  const TodaySummary({
    required this.hasDailyLogToday,
    required this.stroopDone,
    required this.reactionDone,
    required this.readiness,
    required this.dailyLog,
    required this.testsToday,
  });

  final bool hasDailyLogToday;
  final bool stroopDone;
  final bool reactionDone;
  final int readiness;
  final DailyLogCollection? dailyLog;
  final int testsToday;

  int get completedTasks =>
      (hasDailyLogToday ? 1 : 0) + (stroopDone ? 1 : 0) + (reactionDone ? 1 : 0);
}

bool _sameDay(DateTime first, DateTime second) {
  return first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;
}

final todaySummaryProvider = FutureProvider<TodaySummary>((ref) async {
  final repository = ref.watch(repositoryProvider);
  final logs = await repository.recentDailyLogs(limit: 5);
  final results = await repository.recentResults(limit: 40);
  final now = DateTime.now();

  final todayLog = logs
      .where((log) => _sameDay(log.timestamp, now))
      .cast<DailyLogCollection?>()
      .firstWhere((log) => log != null, orElse: () => null);

  final todayResults =
      results.where((result) => _sameDay(result.timestamp, now)).toList();

  return TodaySummary(
    hasDailyLogToday: todayLog != null,
    stroopDone: todayResults.any((r) => r.testType == 'stroop'),
    reactionDone: todayResults.any((r) => r.testType == 'reaction'),
    readiness: todayLog?.readiness ?? 3,
    dailyLog: todayLog,
    testsToday: todayResults.length,
  );
});

final cognitiveHistoryProvider =
    FutureProvider<List<CognitiveTestResultCollection>>((ref) {
  return ref.watch(repositoryProvider).recentResults(limit: 30);
});

final stroopHistoryProvider =
    FutureProvider<List<CognitiveTestResultCollection>>((ref) {
  return ref.watch(repositoryProvider).resultsForType('stroop', limit: 20);
});

final reactionHistoryProvider =
    FutureProvider<List<CognitiveTestResultCollection>>((ref) {
  return ref.watch(repositoryProvider).resultsForType('reaction', limit: 20);
});

final emergencyProtocolsProvider =
    FutureProvider<List<EmergencyProtocolCollection>>((ref) {
  return ref.watch(repositoryProvider).emergencyProtocols();
});

class ProfileStats {
  const ProfileStats({
    required this.dailyLogCount,
    required this.testCount,
    required this.dailyLogs,
    required this.results,
  });

  final int dailyLogCount;
  final int testCount;
  final List<DailyLogCollection> dailyLogs;
  final List<CognitiveTestResultCollection> results;

  double get averageReadiness {
    if (dailyLogs.isEmpty) return 0;
    final total = dailyLogs.fold<int>(0, (sum, log) => sum + log.readiness);
    return total / dailyLogs.length;
  }

  double get averageReaction {
    final reaction =
        results.where((result) => result.testType == 'reaction').toList();
    if (reaction.isEmpty) return 0;
    final total = reaction.fold<double>(
      0,
      (sum, result) => sum + result.averageReactionTimeMs,
    );
    return total / reaction.length;
  }
}

final profileStatsProvider = FutureProvider<ProfileStats>((ref) async {
  final repository = ref.watch(repositoryProvider);
  final counts = await Future.wait([
    repository.dailyLogCount(),
    repository.testCount(),
  ]);
  final logs = await repository.allDailyLogs();
  final results = await repository.allResults();
  return ProfileStats(
    dailyLogCount: counts[0],
    testCount: counts[1],
    dailyLogs: logs,
    results: results,
  );
});
