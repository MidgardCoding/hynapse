import 'package:isar_community/isar.dart';

import '../models/cognitive_test_result_collection.dart';
import '../models/emergency_protocol_collection.dart';

class SeedService {
  SeedService(this._isar);

  final Isar _isar;

  static const prototypeUserId = 'P4J9R-KX0LM-WH7X2';
  static const prototypePassword = r'!KlM90%@atD$';
  static const prototypeUserName = 'Rafał';

  Future<void> seedIfNeeded() async {
    await _seedProtocols();
    await _seedCognitiveHistory();
  }

  Future<void> _seedProtocols() async {
    final count = await _isar.emergencyProtocolCollections.count();
    if (count > 0) return;

    final protocols = <EmergencyProtocolCollection>[
      EmergencyProtocolCollection()
        ..category = 'equipment'
        ..title = 'Spadek ciśnienia w kabinie'
        ..summary =
            'Natychmiastowa reakcja załogi przy spadku ciśnienia poniżej progu operacyjnego.'
        ..isCritical = true
        ..sosActive = false
        ..instructions = [
          'Załóż maskę tlenową i sprawdź przepływ tlenu.',
          'Powiadom dowódcę misji oraz centrum kontroli.',
          'Przejdź do modułu ratunkowego zgodnie z planem.',
          'Zamknij zawory w uszkodzonej sekcji.',
          'Monitoruj ciśnienie i nasycenie krwi tlenem.',
        ],
      EmergencyProtocolCollection()
        ..category = 'health'
        ..title = 'Atak paniki'
        ..summary =
            'Sterowana procedura uspokajająca z ćwiczeniem oddechowym 4-4-4-4.'
        ..isCritical = true
        ..sosActive = false
        ..instructions = [
          'Usiądź stabilnie i oprzyj plecy.',
          'Uruchom prowadzony oddech 4-4-4-4.',
          'Nazwij pięć przedmiotów, które widzisz.',
          'Powiadom partnera załogi o swoim stanie.',
          'Pozostań w kontakcie z personelem medycznym.',
        ],
      EmergencyProtocolCollection()
        ..category = 'location'
        ..title = 'Utrata łączności'
        ..summary =
            'Procedura przy braku telemetrii i utracie kontaktu z centrum kontroli.'
        ..isCritical = true
        ..sosActive = false
        ..instructions = [
          'Sprawdź zasilanie i status anten.',
          'Przełącz na kanał zapasowy.',
          'Wyślij sygnał ratunkowy z pozycją ostatniej telemetrii.',
          'Włącz homing beacon.',
          'Powtarzaj próbę kontaktu co 10 minut.',
        ],
      EmergencyProtocolCollection()
        ..category = 'health'
        ..title = 'Uraz kończyny'
        ..summary = 'Stabilizacja urazu i przygotowanie do konsultacji medycznej.'
        ..isCritical = false
        ..sosActive = false
        ..instructions = [
          'Unieruchom kończynę w pozycji neutralnej.',
          'Zastosuj opatrunek i kontroluj krwawienie.',
          'Podaj leki przeciwbólowe zgodnie z kartą medyczną.',
          'Skontaktuj się z chirurgiem misji.',
        ],
      EmergencyProtocolCollection()
        ..category = 'travel'
        ..title = 'Utrata orientacji'
        ..summary =
            'Odzyskanie pozycji podczas EVA lub przemieszczania w trudnym terenie.'
        ..isCritical = false
        ..sosActive = false
        ..instructions = [
          'Zatrzymaj się i pozostań w miejscu.',
          'Odczytaj ostatnią znaną pozycję z urządzenia.',
          'Aktywuj sygnał lokalizacyjny.',
          'Wróć do ostatniego punktu orientacyjnego.',
          'Zgłoś status do bazy.',
        ],
      EmergencyProtocolCollection()
        ..category = 'travel'
        ..title = 'Awaria środka transportu'
        ..summary = 'Bezpieczne zatrzymanie i zabezpieczenie zespołu.'
        ..isCritical = false
        ..sosActive = false
        ..instructions = [
          'Zatrzymaj pojazd w bezpiecznym miejscu.',
          'Zabezpiecz strefę i załóż kamizelki.',
          'Sprawdź stan zespołu.',
          'Wezwij wsparcie techniczne.',
        ],
      EmergencyProtocolCollection()
        ..category = 'equipment'
        ..title = 'Awaria systemu tlenowego'
        ..summary = 'Przełączenie na zapasowy obieg tlenu.'
        ..isCritical = true
        ..sosActive = false
        ..instructions = [
          'Przełącz obieg na zbiornik zapasowy.',
          'Sprawdź wskaźniki ciśnienia i przepływu.',
          'Wyłącz uszkodzoną sekcję.',
          'Zgłoś zdarzenie i pozostań przy panelu.',
        ],
      EmergencyProtocolCollection()
        ..category = 'supplies'
        ..title = 'Krytyczny brak zasobów'
        ..summary = 'Racjonowanie wody, żywności i energii.'
        ..isCritical = false
        ..sosActive = false
        ..instructions = [
          'Sporządź inwentaryzację zasobów.',
          'Wprowadź racjonowanie według priorytetów misji.',
          'Wyłącz niekrytyczne systemy.',
          'Zgłoś prognozę zapasów do centrum kontroli.',
        ],
      EmergencyProtocolCollection()
        ..category = 'auth'
        ..title = 'Awaria autoryzacji'
        ..summary = 'Przywrócenie dostępu do terminala w trybie offline.'
        ..isCritical = false
        ..sosActive = false
        ..instructions = [
          'Wprowadź jednorazowy kod ratunkowy.',
          'Zweryfikuj tożsamość przez partnera załogi.',
          'Uruchom terminal w trybie offline.',
          'Zapisz zdarzenie w dzienniku audytowym.',
        ],
      EmergencyProtocolCollection()
        ..category = 'other'
        ..title = 'Procedura ogólna'
        ..summary = 'Uniwersalny schemat eskalacji nieznanego zdarzenia.'
        ..isCritical = false
        ..sosActive = false
        ..instructions = [
          'Zabezpiecz siebie i najbliższe otoczenie.',
          'Określ rodzaj zagrożenia.',
          'Powiadom dowódcę misji.',
          'Uruchom właściwą procedurę szczegółową.',
          'Prowadź zapis zdarzeń do czasu ustabilizowania sytuacji.',
        ],
    ];

    await _isar.writeTxn(
      () => _isar.emergencyProtocolCollections.putAll(protocols),
    );
  }

  Future<void> _seedCognitiveHistory() async {
    final count = await _isar.cognitiveTestResultCollections.count();
    if (count > 0) return;

    final now = DateTime.now();
    final results = <CognitiveTestResultCollection>[
      CognitiveTestResultCollection()
        ..userId = prototypeUserId
        ..testType = 'stroop'
        ..correctCount = 14
        ..incorrectCount = 3
        ..averageReactionTimeMs = 782
        ..timestamp = now.subtract(const Duration(days: 4, hours: 1)),
      CognitiveTestResultCollection()
        ..userId = prototypeUserId
        ..testType = 'stroop'
        ..correctCount = 16
        ..incorrectCount = 2
        ..averageReactionTimeMs = 731
        ..timestamp = now.subtract(const Duration(days: 3, hours: 2)),
      CognitiveTestResultCollection()
        ..userId = prototypeUserId
        ..testType = 'stroop'
        ..correctCount = 15
        ..incorrectCount = 4
        ..averageReactionTimeMs = 744
        ..timestamp = now.subtract(const Duration(days: 2, hours: 1)),
      CognitiveTestResultCollection()
        ..userId = prototypeUserId
        ..testType = 'stroop'
        ..correctCount = 17
        ..incorrectCount = 2
        ..averageReactionTimeMs = 698
        ..timestamp = now.subtract(const Duration(days: 1, hours: 3)),
      CognitiveTestResultCollection()
        ..userId = prototypeUserId
        ..testType = 'reaction'
        ..correctCount = 12
        ..incorrectCount = 2
        ..averageReactionTimeMs = 312
        ..timestamp = now.subtract(const Duration(days: 3, hours: 5)),
      CognitiveTestResultCollection()
        ..userId = prototypeUserId
        ..testType = 'reaction'
        ..correctCount = 14
        ..incorrectCount = 1
        ..averageReactionTimeMs = 287
        ..timestamp = now.subtract(const Duration(days: 1, hours: 4)),
    ];

    await _isar.writeTxn(
      () => _isar.cognitiveTestResultCollections.putAll(results),
    );
  }
}
