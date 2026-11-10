import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/hud_button.dart';
import '../../widgets/hud_route.dart';
import '../../widgets/hud_scaffold.dart';
import '../../widgets/section_title.dart';
import 'auth_password_screen.dart';

class AuthIdScreen extends StatefulWidget {
  const AuthIdScreen({super.key});

  @override
  State<AuthIdScreen> createState() => _AuthIdScreenState();
}

class _AuthIdScreenState extends State<AuthIdScreen> {
  static const _prototypeId = 'P4J9R-KX0LM-WH7X2';
  late final TextEditingController _controller;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _prototypeId);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _continue() {
    final value = _controller.text.trim();
    if (value.isEmpty) {
      setState(() => _error = 'Wpisz identyfikator operatora.');
      return;
    }
    if (!RegExp(r'^[A-Za-z0-9-]{8,}$').hasMatch(value)) {
      setState(() => _error = 'Nieprawidłowy format identyfikatora.');
      return;
    }
    setState(() => _error = null);
    Navigator.of(context).push(
      hudRoute(AuthPasswordScreen(userId: value.toUpperCase())),
    );
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
                        'Wpisz identyfikator',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              fontSize: 34,
                              letterSpacing: -0.4,
                            ),
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: _controller,
                        textAlign: TextAlign.center,
                        autocorrect: false,
                        enableSuggestions: false,
                        textCapitalization: TextCapitalization.characters,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(
                          fontFamily: 'SansExpanded',
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.6,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'ID operatora',
                          fillColor: Color(0x88414B7D),
                        ),
                        onSubmitted: (_) => _continue(),
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
                        'Twój identyfikator został nadany przez administratora zespołu. '
                        'W przypadku zapomnienia identyfikatora prosimy o kontakt '
                        'z administratorem zespołu.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.72),
                              height: 1.45,
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
                              'IDENTYFIKATOR DLA WERSJI PROTOTYPOWEJ',
                              style: TextStyle(
                                fontSize: 9,
                                letterSpacing: 1.1,
                                fontWeight: FontWeight.w700,
                                color: Colors.white.withValues(alpha: 0.42),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const SelectableText(
                              _prototypeId,
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
                        label: 'Kontynuuj',
                        icon: Icons.arrow_forward_rounded,
                        onPressed: _continue,
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
