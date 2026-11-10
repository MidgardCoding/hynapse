import 'package:isar_community/isar.dart';

part 'cognitive_test_result_collection.g.dart';

/// Wynik pojedynczego testu poznawczego.
@collection
class CognitiveTestResultCollection {
  Id id = Isar.autoIncrement;

  @Index()
  late String userId;

  /// stroop | reaction
  @Index()
  late String testType;

  late int correctCount;

  late int incorrectCount;

  late double averageReactionTimeMs;

  @Index()
  late DateTime timestamp;

  String get testLabel => testType == 'stroop' ? 'Stroop' : 'Czas reakcji';
}
