import 'package:flutter_test/flutter_test.dart';
import 'package:hynapse/main.dart';

void main() {
  testWidgets('Welcome screen renders the Hynapse entry points', (tester) async {
    await tester.pumpWidget(const HynapseApp());
    await tester.pump(const Duration(milliseconds: 900));

    expect(find.text('Hynapse'), findsOneWidget);
    expect(find.text('Autoryzacja'), findsOneWidget);
    expect(find.text('Wyjdź'), findsOneWidget);
    expect(find.text('Tryb awaryjny'), findsOneWidget);
  });
}
