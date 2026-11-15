import 'dart:math';

class VoiceAnalysisResult {
  const VoiceAnalysisResult({
    required this.fatigue,
    required this.sleepDeprivation,
    required this.stress,
    required this.speechClarity,
    required this.readiness,
    required this.transcript,
    required this.recommendationTitle,
    required this.recommendation,
  });

  final int fatigue;
  final int sleepDeprivation;
  final int stress;
  final int speechClarity;
  final int readiness;
  final String transcript;
  final String recommendationTitle;
  final String recommendation;

  double get average =>
      (fatigue + sleepDeprivation + stress + speechClarity) / 4;

  bool get needsRecovery =>
      fatigue >= 4 || sleepDeprivation >= 4 || stress >= 4;
}

class VoiceAnalysisService {
  const VoiceAnalysisService();

  /// Prototyp: analiza odbywa się lokalnie na bazie długości wypowiedzi
  /// i profilu demonstracyjnego. Interfejs jest gotowy na podłączenie modelu
  /// on-device (np. TFLite) bez zmian w warstwie widoków.
  VoiceAnalysisResult analyse(Duration duration, {int seed = 0}) {
    final random = Random(seed + duration.inSeconds);
    final fatigue = 3 + random.nextInt(3); // 3–5
    final sleep = 1 + random.nextInt(3); // 1–3
    final stress = 2 + random.nextInt(3); // 2–4
    final speech = 4 + random.nextInt(3); // 4–6
    final readiness = ((fatigue + (6 - sleep) + (6 - stress) + speech) / 4)
        .round()
        .clamp(0, 6);

    final highFatigue = fatigue >= 4;
    final highSleep = sleep >= 4;
    final highStress = stress >= 4;

    final title = highFatigue
        ? 'Podwyższone przemęczenie'
        : highSleep
            ? 'Wysoki poziom niewyspania'
            : highStress
                ? 'Podwyższony poziom stresu'
                : 'Stabilny profil operacyjny';

    final recommendation = highFatigue
        ? 'Zalecany 20-minutowy odpoczynek przed kolejnym zadaniem, '
            'ograniczenie bodźców i wcześniejszy sen. Powtórz test Stroopa '
            'po regeneracji. Jeśli wynik się pogorszy, zgłoś się do '
            'personelu medycznego misji.'
        : highSleep
            ? 'Zalecany 20-minutowy odpoczynek przed kolejnym zadaniem, '
                'ograniczenie bodźców i wcześniejszy sen. Powtórz test Stroopa '
                'po regeneracji. Jeśli wynik się pogorszy, zgłoś się do '
                'personelu medycznego misji.'
            : highStress
                ? 'Wykonaj ćwiczenie oddechowe 4-4-4-4 z modułu awaryjnego, '
                    'a następnie krótki test czasu reakcji. Unikaj decyzji '
                    'krytycznych do momentu obniżenia tętna.'
                : 'Utrzymaj obecny rytm dnia. Zadbaj o nawodnienie i wykonaj '
                    'zaplanowane testy poznawcze. Brak działań korygujących.';

    return VoiceAnalysisResult(
      fatigue: fatigue,
      sleepDeprivation: sleep,
      stress: stress,
      speechClarity: speech,
      readiness: readiness,
      transcript:
          'Wczorajszy dzień był wymagający. W nocy spałem krótko, ale zachowałem '
          'koncentrację podczas pracy przy panelu. Czuję lekkie zmęczenie i '
          'napięcie, jednak jestem gotowy do realizacji zadań.',
      recommendationTitle: title,
      recommendation: recommendation,
    );
  }
}
