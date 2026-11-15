import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/app_providers.dart';
import '../../theme/app_colors.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/hud_button.dart';
import '../../widgets/hud_route.dart';
import '../../widgets/hud_scaffold.dart';
import '../../widgets/section_title.dart';
import '../../services/seed_service.dart';
import 'sync_screen.dart';

class AuthPasswordScreen extends ConsumerStatefulWidget {
  const AuthPasswordScreen({super.key, required this.userId});

  final String userId;

  @override
  ConsumerState<AuthPasswordScreen> createState() => _AuthPasswordScreenState();
}

class _AuthPasswordScreenState extends ConsumerState<AuthPasswordScreen> {
  late final TextEditingController _controller;
  bool _obscure = true;
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: SeedService.prototypePassword);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _authorize() async {
    if (_loading) return;
    final auth = ref.read(authServiceProvider);
    if (!auth.validateId(widget.userId)) {
      setState(() => _error = 'Identyfikator nie istnieje w bazie zespołu.');
      return;
    }
    if (!auth.validatePassword(_controller.text)) {
      setState(() => _error = 'Nieprawidłowe hasło. Spróbuj ponownie.');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      await ref.read(sessionProvider.notifier).authorize(
            userId: widget.userId,
            displayName: auth.displayNameFor(widget.userId),
          );
      if (!mounted) return;
      Navigator.of(context).pushReplacement(hudRoute(const SyncScreen()));
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'Nie udało się otworzyć lokalnej sesji. Spróbuj ponownie.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return HudScaffold(
      title: 'Autoryzacja',
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.viewInsetsOf(context).bottom,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: ContentWidth(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 24),
                      Text(
                        'Wpisz hasło',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              fontSize: 34,
                              letterSpacing: -0.4,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sesja: ${widget.userId}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          letterSpacing: 0.8,
                          color: Colors.white.withValues(alpha: 0.40),
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: _controller,
                        obscureText: _obscure,
                        autocorrect: false,
                        enableSuggestions: false,
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(
                          fontFamily: 'SansExpanded',
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.6,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Hasło',
                          fillColor: const Color(0x88414B7D),
                          suffixIcon: IconButton(
                            tooltip: _obscure ? 'Pokaż hasło' : 'Ukryj hasło',
                            onPressed: () {
                              setState(() => _obscure = !_obscure);
                            },
                            icon: Icon(
                              _obscure
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              color: Colors.white.withValues(alpha: 0.6),
                            ),
                          ),
                        ),
                        onSubmitted: (_) => _authorize(),
                        onChanged: (_) {
                          if (_error != null) setState(() => _error = null);
                        },
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 220),
                        child: _error == null
                            ? const SizedBox(height: 14)
                            : Padding(
                                key: ValueKey(_error),
                                padding: const EdgeInsets.only(top: 10, bottom: 4),
                                child: Text(
                                  _error!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: AppColors.danger,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                      ),
                      Text(
                        'W przypadku zapomnienia hasła prosimy o kontakt z '
                        'administratorem zespołu.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.72),
                            ),
                      ),
                      const SizedBox(height: 18),
                      GlassCard(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 14,
                        ),
                        color: Colors.black.withValues(alpha: 0.16),
                        radius: 16,
                        child: Column(
                          children: [
                            Text(
                              'HASŁO DLA WERSJI PROTOTYPOWEJ',
                              style: TextStyle(
                                fontSize: 9,
                                letterSpacing: 1.1,
                                fontWeight: FontWeight.w700,
                                color: Colors.white.withValues(alpha: 0.42),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const SelectableText(
                              SeedService.prototypePassword,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'SansExpanded',
                                fontSize: 13,
                                letterSpacing: 0.8,
                                color: AppColors.cyanSoft,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      HudButton(
                        label: _loading ? 'Autoryzacja...' : 'Autoryzuj',
                        icon: _loading ? null : Icons.fingerprint_rounded,
                        onPressed: _loading ? null : _authorize,
                        trailing: _loading
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color(0xFF001C20),
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(height: 22),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lock_outline_rounded,
                            size: 13,
                            color: Colors.white.withValues(alpha: 0.34),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Dane przechowywane lokalnie · Isar',
                            style: TextStyle(
                              fontSize: 10,
                              letterSpacing: 0.3,
                              color: Colors.white.withValues(alpha: 0.34),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
