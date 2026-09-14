class Goal {
  final int id;
  final String name;
  final String description;
  final double targetAmount;
  final double savedAmount;
  final DateTime targetDate;
  final String icon;

  Goal({
    required this.id,
    required this.name,
    required this.description,
    required this.targetAmount,
    required this.savedAmount,
    required this.targetDate,
    required this.icon,
  });

  double get progress {
    if (targetAmount <= 0) return 0;

    return (savedAmount / targetAmount)
        .clamp(0.0, 1.0);
  }

  double get remaining {
    return (targetAmount - savedAmount)
        .clamp(0.0, double.infinity);
  }
}