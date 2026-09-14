import 'package:flutter/foundation.dart';
import '../models/goal.dart';

class GoalStore extends ChangeNotifier {
  final List<Goal> _goals = [
    Goal(
      id: 1,
      name: 'Emergency Fund',
      description: 'Build a safety cushion',
      targetAmount: 20000,
      savedAmount: 8500,
      targetDate: DateTime.now().add(const Duration(days: 120)),
      icon: '🛡️',
    ),
    Goal(
      id: 2,
      name: 'New Laptop',
      description: 'Save for school and work',
      targetAmount: 60000,
      savedAmount: 18000,
      targetDate: DateTime.now().add(const Duration(days: 240)),
      icon: '💻',
    ),
  ];

  List<Goal> get goals => List.unmodifiable(_goals);

  double get totalSaved {
    return _goals.fold(
      0,
      (total, goal) => total + goal.savedAmount,
    );
  }

  void addGoal({
    required String name,
    required String description,
    required double targetAmount,
    required DateTime targetDate,
    required String icon,
  }) {
    _goals.add(
      Goal(
        id: DateTime.now().millisecondsSinceEpoch,
        name: name,
        description: description,
        targetAmount: targetAmount,
        savedAmount: 0,
        targetDate: targetDate,
        icon: icon,
      ),
    );

    notifyListeners();
  }

  void addSavings(int goalId, double amount) {
    final index = _goals.indexWhere((goal) => goal.id == goalId);

    if (index == -1) return;

    final goal = _goals[index];

    _goals[index] = Goal(
      id: goal.id,
      name: goal.name,
      description: goal.description,
      targetAmount: goal.targetAmount,
      savedAmount: goal.savedAmount + amount,
      targetDate: goal.targetDate,
      icon: goal.icon,
    );

    notifyListeners();
  }
}