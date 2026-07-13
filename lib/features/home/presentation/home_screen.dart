import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/liquid_glass.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.transparent,
          floating: true,
          title: const Text(
            'MINDVAULT',
            style: TextStyle(fontSize: 14, letterSpacing: 3),
          ),
          actions: [
            IconButton(
              tooltip: 'Settings',
              onPressed: () => context.push('/settings'),
              icon: const Icon(Icons.tune_rounded),
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
          sliver: SliverList.list(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good evening',
                          style: TextStyle(color: VaultColors.muted),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'What’s on your mind?',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const AnimatedAIOrb(size: 82),
                ],
              ),
              const SizedBox(height: 24),
              TextField(
                readOnly: true,
                onTap: () => context.push('/search'),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search your mind',
                ),
              ),
              const SizedBox(height: 16),
              LiquidGlassCard(
                child: Row(
                  children: [
                    const Icon(
                      Icons.data_usage_rounded,
                      color: VaultColors.warning,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Gemini budget'),
                          Text(
                            'Mock mode • no usage charges',
                            style: TextStyle(
                              color: VaultColors.muted,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.push('/settings/ai'),
                      child: const Text('Manage'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              _heading(context, 'Quick capture'),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _quick(context, Icons.mic_rounded, 'Record thought'),
                  _quick(context, Icons.edit_rounded, 'Brain dump'),
                  _quick(context, Icons.upload_file_rounded, 'Upload file'),
                  _quick(context, Icons.chat_bubble_outline, 'Ask AI'),
                ],
              ),
              const SizedBox(height: 28),
              _heading(
                context,
                'This week’s digest',
                action: () => context.push('/digest'),
              ),
              const SizedBox(height: 12),
              LiquidGlassCard(
                onTap: () => context.push('/digest'),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ideas are becoming decisions',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '12 memories captured · 3 decisions · 4 open threads',
                      style: TextStyle(color: VaultColors.muted),
                    ),
                    SizedBox(height: 14),
                    Text(
                      'Your Flutter architecture decision connects to two earlier product notes.',
                      style: TextStyle(height: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              _heading(
                context,
                'Active Rituals',
                action: () => context.push('/automation'),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 92,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    SizedBox(
                      width: 240,
                      child: LiquidGlassCard(
                        child: Row(
                          children: [
                            Icon(Icons.replay_rounded, color: VaultColors.cyan),
                            SizedBox(width: 12),
                            Expanded(child: Text('Revisit untouched #ideas')),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    SizedBox(
                      width: 240,
                      child: LiquidGlassCard(
                        child: Row(
                          children: [
                            Icon(
                              Icons.task_alt_rounded,
                              color: VaultColors.violet,
                            ),
                            SizedBox(width: 12),
                            Expanded(child: Text('Surface open tasks Sunday')),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              _heading(
                context,
                'Recent memories',
                action: () => context.go('/memories'),
              ),
              const SizedBox(height: 12),
              ...[
                'Private memory workspace',
                'Flutter architecture decision',
              ].map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: LiquidGlassCard(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.auto_awesome,
                          size: 18,
                          color: VaultColors.cyan,
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(e)),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  static Widget _heading(BuildContext c, String text, {VoidCallback? action}) =>
      Row(
        children: [
          Expanded(child: Text(text, style: Theme.of(c).textTheme.titleLarge)),
          if (action != null)
            TextButton(onPressed: action, child: const Text('View all')),
        ],
      );
  static Widget _quick(BuildContext c, IconData icon, String label) => SizedBox(
    width: (MediaQuery.sizeOf(c).width - 50) / 2,
    child: LiquidGlassCard(
      onTap: () => label == 'Ask AI' ? c.push('/chat') : c.push('/capture'),
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Icon(icon, color: VaultColors.cyan),
          const SizedBox(width: 9),
          Flexible(child: Text(label)),
        ],
      ),
    ),
  );
}
