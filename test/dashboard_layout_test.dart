import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hynapse/providers/app_providers.dart';
import 'package:hynapse/services/hynapse_repository.dart';
import 'package:hynapse/services/isar_service.dart';
import 'package:hynapse/theme/app_theme.dart';
import 'package:hynapse/views/dashboard/dashboard_screen.dart';
import 'package:hynapse/widgets/app_background.dart';

class _FakeIsarService implements IsarService {
  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('Fake IsarService');
}

class _FakeSessionController extends SessionController {
  _FakeSessionController() : super(HynapseRepository(_FakeIsarService()));

  @override
  Future<void> reload() async {}
}

void main() {
  testWidgets('dashboard lays out all scroll content', (tester) async {
    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sessionProvider.overrideWith((ref) => _FakeSessionController()),
          todaySummaryProvider.overrideWith(
            (ref) async => const TodaySummary(
              hasDailyLogToday: false,
              stroopDone: false,
              reactionDone: false,
              readiness: 3,
              dailyLog: null,
              testsToday: 0,
            ),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.dark,
          home: Scaffold(
            body: AppBackground(
              child: DashboardScreen(
                onOpenSettings: () {},
                onOpenEmergency: () {},
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    for (final label in [
      'WITAJ, RAFAŁ!',
      'ZADANIA NA DZISIAJ',
      'PRZEGLĄD DZIENNY',
      'TEST STROOPA',
      'CZAS REAKCJI',
    ]) {
      final finder = find.text(label);
      expect(finder, findsOneWidget, reason: 'Missing dashboard label: $label');
      expect(
        tester.getSize(finder),
        isNot(Size.zero),
        reason: 'Dashboard label has zero size: $label',
      );
    }

    final scroll = tester.getSize(find.byType(SingleChildScrollView));
    final content = find.descendant(
      of: find.byType(SingleChildScrollView),
      matching: find.byType(Column),
    );
    expect(content, findsWidgets);
    expect(
      tester.getSize(content.first).height,
      greaterThan(scroll.height),
      reason: 'Scroll content should be taller than the viewport',
    );
  });
}
