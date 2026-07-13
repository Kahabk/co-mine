import 'package:flutter_test/flutter_test.dart';
import 'package:mindvault_ai/services/ai/ai_models.dart';
import 'package:mindvault_ai/services/ai/cost_governor.dart';

void main() {
  test('queues background work over budget but allows explicit chat', () {
    final governor = CostGovernor(monthlyBudget: 1, spent: .95);
    const estimate = UsageEstimate(
      inputTokens: 10,
      outputTokens: 10,
      estimatedCost: .1,
    );
    expect(
      governor.evaluate(estimate, AIFeaturePriority.background).allowed,
      isFalse,
    );
    expect(
      governor.evaluate(estimate, AIFeaturePriority.userInitiated).allowed,
      isTrue,
    );
  });
}
