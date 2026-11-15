import 'package:isar_community/isar.dart';

part 'daily_log_collection.g.dart';

/// Poranny check-in: skala 0–6 dla trzech wskaźników oraz transkrypcja głosu.
@collection
class DailyLogCollection {
  Id id = Isar.autoIncrement;

  @Index()
  late String userId;

  /// 0 = brak zmęczenia, 6 = skrajne zmęczenie.
  late int fatigue;

  /// 0 = wyspany, 6 = skrajna deprywacja snu.
  late int sleepDeprivation;

  /// 0 = spokój, 6 = skrajny stres.
  late int stress;

  /// 0–6, wyższy wynik oznacza lepszą klarowność mowy.
  late int speechClarity;

  late String transcript;

  /// Wynik ogólnej gotowości 0–6.
  late int readiness;

  @Index()
  late DateTime timestamp;

  String get timestampLabel {
    final d = timestamp;
    String two(int value) => value.toString().padLeft(2, '0');
    return '${two(d.day)}.${two(d.month)}.${d.year} · ${two(d.hour)}:${two(d.minute)}';
  }
}
