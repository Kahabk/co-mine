import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/liquid_glass.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  int page = 0;
  static const pages = [
    (
      'Your mind, extended.',
      'Capture thoughts, conversations, ideas, files, and memories inside one intelligent private space.',
      Icons.psychology_alt_rounded,
    ),
    (
      'Turn chaos into clarity.',
      'Gemini analyzes your brain dumps, discovers relationships, and transforms them into structured visual mind maps.',
      Icons.hub_rounded,
    ),
    (
      'An AI that remembers.',
      'Every approved memory can become context for future conversations without losing its source.',
      Icons.auto_awesome_rounded,
    ),
    (
      'Connect your desktop.',
      'Access files, projects, logs, applications, and approved workflows from your phone.',
      Icons.laptop_rounded,
    ),
    (
      "It works while you don't.",
      'MindVault quietly surfaces weekly recalls, unfinished tasks, and gentle reminders — never notifications for their own sake.',
      Icons.nights_stay_rounded,
    ),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => context.go('/home'),
                child: const Text('Skip'),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller,
                onPageChanged: (v) => setState(() => page = v),
                itemCount: pages.length,
                itemBuilder: (_, i) {
                  final p = pages[i];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: VaultColors.accent,
                          boxShadow: [
                            BoxShadow(
                              color: VaultColors.violet.withValues(alpha: .24),
                              blurRadius: 50,
                            ),
                          ],
                        ),
                        child: Icon(p.$3, size: 62),
                      ),
                      const SizedBox(height: 52),
                      Text(
                        p.$1,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 18),
                      Text(
                        p.$2,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: VaultColors.muted,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.all(4),
                  width: i == page ? 28 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: i == page ? VaultColors.cyan : Colors.white24,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            LiquidGlassButton(
              label: page == 4 ? 'Enter your vault' : 'Continue',
              onPressed: () {
                if (page == 4) {
                  context.go('/home');
                } else {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }
              },
            ),
            const SizedBox(height: 12),
            Text(
              'Local-only by default • Gemini costs are always visible',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    ),
  );
}
