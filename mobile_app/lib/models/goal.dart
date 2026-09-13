class Goal {
  final int id;
  final String title;
  final String category;
  final double targetAmount;
  final double savedAmount;
  final String? deadline;

  Goal({
    required this.id,
    required this.title,
    required this.category,
    required this.targetAmount,
    required this.savedAmount,
    this.deadline,
  });

  double get progress {
    if (targetAmount <= 0) return 0;

    final value = savedAmount / targetAmount;

    return value.clamp(0.0, 1.0);
  }

  double get remainingAmount {
    final remaining = targetAmount - savedAmount;

    return remaining < 0 ? 0 : remaining;
  }
}