import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindvault_ai/core/widgets/liquid_glass.dart';

void main() {
  testWidgets('glass card renders reduced-transparency fallback', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LiquidGlassCard(
            reducedTransparency: true,
            child: Text('Private'),
          ),
        ),
      ),
    );
    expect(find.text('Private'), findsOneWidget);
  });
}
