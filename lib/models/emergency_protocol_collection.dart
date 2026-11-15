import 'package:isar_community/isar.dart';

part 'emergency_protocol_collection.g.dart';

/// Procedura awaryjna dostępna offline. [sosActive] jest zapisywany lokalnie.
@collection
class EmergencyProtocolCollection {
  Id id = Isar.autoIncrement;

  @Index()
  late String category;

  @Index()
  late String title;

  late List<String> instructions;

  late bool sosActive;

  late String summary;

  late bool isCritical;

  String get categoryLabel {
    switch (category) {
      case 'health':
        return 'Problemy zdrowotne';
      case 'travel':
        return 'Problemy z podróżą';
      case 'equipment':
        return 'Awaria narzędzi';
      case 'supplies':
        return 'Brak zasobów';
      case 'location':
        return 'Nieznana lokalizacja';
      case 'auth':
        return 'Awaria autoryzacji';
      default:
        return 'Inny problem';
    }
  }
}
