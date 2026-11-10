import 'package:isar_community/isar.dart';

part 'user_session_collection.g.dart';

/// Profil i stan sesji operatora zapisany lokalnie w Isar.
@collection
class UserSessionCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String userId;

  late String displayName;

  late bool isAuthorized;

  /// astronaut | earth
  late String role;

  late DateTime lastSync;

  DateTime get lastSynchronization => lastSync;
}
