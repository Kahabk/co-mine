import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/theme/app_theme.dart';
import '../features/capture/presentation/capture_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => VaultShell(child: child),
      routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
        GoRoute(
          path: '/memories',
          builder: (context, state) => const PlaceholderScreen(
            title: 'Memories',
            icon: Icons.library_books_rounded,
          ),
        ),
        GoRoute(
          path: '/capture',
          builder: (_, state) =>
              CaptureScreen(initialText: state.uri.queryParameters['text']),
        ),
        GoRoute(
          path: '/mind-map',
          builder: (context, state) => const PlaceholderScreen(
            title: 'Mind Map',
            icon: Icons.hub_rounded,
          ),
        ),
        GoRoute(
          path: '/chat',
          builder: (context, state) => const PlaceholderScreen(
            title: 'MindVault AI',
            icon: Icons.auto_awesome_rounded,
          ),
        ),
      ],
    ),
    ..._routeTable.map(
      (path) => GoRoute(
        path: path,
        builder: (_, state) =>
            PlaceholderScreen(title: _title(path), icon: _icon(path)),
      ),
    ),
  ],
);

const _routeTable = [
  '/memory/:id',
  '/chat/:id',
  '/search',
  '/projects',
  '/desktop',
  '/desktop/activity',
  '/digest',
  '/digest/:id',
  '/automation',
  '/automation/:id',
  '/settings',
  '/settings/privacy',
  '/settings/ai',
  '/settings/security',
  '/settings/accessibility',
  '/settings/data',
  '/profile',
];
String _title(String path) => path
    .split('/')
    .where((e) => e.isNotEmpty && !e.startsWith(':'))
    .map((e) => '${e[0].toUpperCase()}${e.substring(1)}')
    .join(' · ');
IconData _icon(String p) => p.contains('settings')
    ? Icons.settings_rounded
    : p.contains('desktop')
    ? Icons.laptop_rounded
    : p.contains('digest')
    ? Icons.auto_stories_rounded
    : p.contains('automation')
    ? Icons.bolt_rounded
    : Icons.layers_rounded;

class VaultShell extends StatelessWidget {
  const VaultShell({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final path = GoRouterState.of(context).uri.path;
    final index = path.startsWith('/memories')
        ? 1
        : path.startsWith('/capture')
        ? 2
        : path.startsWith('/mind-map')
        ? 3
        : path.startsWith('/chat')
        ? 4
        : 0;
    return Scaffold(
      extendBody: true,
      body: child,
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xEE0A0D12),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.white12),
          ),
          child: NavigationBar(
            backgroundColor: Colors.transparent,
            indicatorColor: VaultColors.violet.withValues(alpha: .25),
            selectedIndex: index,
            onDestinationSelected: (i) => context.go(
              ['/home', '/memories', '/capture', '/mind-map', '/chat'][i],
            ),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.memory_outlined),
                selectedIcon: Icon(Icons.memory),
                label: 'Memories',
              ),
              NavigationDestination(
                icon: Icon(Icons.add_circle, size: 34, color: VaultColors.cyan),
                label: 'Capture',
              ),
              NavigationDestination(
                icon: Icon(Icons.hub_outlined),
                selectedIcon: Icon(Icons.hub),
                label: 'Map',
              ),
              NavigationDestination(
                icon: Icon(Icons.auto_awesome_outlined),
                selectedIcon: Icon(Icons.auto_awesome),
                label: 'AI',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title), backgroundColor: Colors.transparent),
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 64, color: VaultColors.cyan),
          const SizedBox(height: 18),
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          const Text(
            'Foundation route ready for the next implementation phase.',
            style: TextStyle(color: VaultColors.muted),
          ),
        ],
      ),
    ),
  );
}
