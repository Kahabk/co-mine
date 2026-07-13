import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import 'router.dart';

class MindVaultApp extends StatelessWidget {
  const MindVaultApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'MindVault AI',
    debugShowCheckedModeBanner: false,
    theme: vaultTheme(),
    routerConfig: appRouter,
  );
}
