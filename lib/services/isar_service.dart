import 'dart:io';

import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/cognitive_test_result_collection.dart';
import '../models/daily_log_collection.dart';
import '../models/emergency_protocol_collection.dart';
import '../models/user_session_collection.dart';

class IsarService {
  IsarService(this.db);

  final Isar db;

  static Future<IsarService> open() async {
    if (Isar.instanceNames.isNotEmpty) {
      return IsarService(Isar.getInstance()!);
    }

    final directory = await _databaseDirectory();
    final isar = await Isar.open(
      [
        UserSessionCollectionSchema,
        DailyLogCollectionSchema,
        CognitiveTestResultCollectionSchema,
        EmergencyProtocolCollectionSchema,
      ],
      directory: directory,
      inspector: true,
      name: 'hynapse',
    );
    return IsarService(isar);
  }

  static Future<String> _databaseDirectory() async {
    if (Platform.isAndroid || Platform.isIOS || Platform.isMacOS) {
      final dir = await getApplicationSupportDirectory();
      return dir.path;
    }
    if (Platform.isWindows || Platform.isLinux) {
      final dir = await getApplicationSupportDirectory();
      return dir.path;
    }
    return Directory.current.path;
  }
}
