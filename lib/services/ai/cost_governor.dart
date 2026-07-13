import 'ai_models.dart';

enum AIFeaturePriority { userInitiated, normal, background }

class CostDecision {
  const CostDecision(this.allowed, this.reason);
  final bool allowed;
  final String reason;
}

class CostGovernor {
  CostGovernor({required this.monthlyBudget, this.spent = 0});
  final double monthlyBudget;
  double spent;
  CostDecision evaluate(UsageEstimate estimate, AIFeaturePriority priority) {
    if (priority == AIFeaturePriority.userInitiated) {
      return const CostDecision(true, 'Explicit user request');
    }
    if (spent + estimate.estimatedCost > monthlyBudget) {
      return const CostDecision(
        false,
        'Monthly AI budget reached; queued for later.',
      );
    }
    return const CostDecision(true, 'Within monthly budget');
  }

  void record(UsageEstimate estimate) => spent += estimate.estimatedCost;
  double get fractionUsed =>
      monthlyBudget <= 0 ? 1 : (spent / monthlyBudget).clamp(0, 1);
}
