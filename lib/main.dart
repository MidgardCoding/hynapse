import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/app_providers.dart';
import 'services/isar_service.dart';
import 'services/seed_service.dart';
import 'theme/app_theme.dart';
import 'views/welcome/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    final service = await IsarService.open();
    final seed = SeedService(service.db);
    await seed.seedIfNeeded();

    runApp(
      ProviderScope(
        overrides: [isarProvider.overrideWithValue(service.db)],
        child: const HynapseApp(),
      ),
    );
  } catch (error, stackTrace) {
    debugPrint('Hynapse startup error: $error\n$stackTrace');
    runApp(_StartupErrorApp(error: error));
  }
}

class HynapseApp extends StatelessWidget {
  const HynapseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hynapse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      scrollBehavior: const _HynapseScrollBehavior(),
      builder: (context, child) {
        final media = MediaQuery.of(context);
        return MediaQuery(
          data: media.copyWith(
            textScaler: media.textScaler.clamp(
              minScaleFactor: 0.9,
              maxScaleFactor: 1.15,
            ),
          ),
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: const Color(0xFF0B0E20),
              systemNavigationBarIconBrightness: Brightness.light,
            ),
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
      home: const WelcomeScreen(),
    );
  }
}

class _HynapseScrollBehavior extends MaterialScrollBehavior {
  const _HynapseScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
  };
}

class _StartupErrorApp extends StatelessWidget {
  const _StartupErrorApp({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: Scaffold(
        backgroundColor: const Color(0xFF0B0F19),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.storage_rounded,
                    color: Color(0xFFFF9F0A),
                    size: 54,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Nie udało się uruchomić bazy Isar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Bungee',
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Uruchom aplikację na urządzeniu lub emulatorze mobilnym. '
                    'Warstwa danych wymaga natywnej biblioteki Isar.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFFB8BDD1), height: 1.5),
                  ),
                  const SizedBox(height: 18),
                  SelectableText(
                    '$error',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF7D849D),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
