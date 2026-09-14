import 'package:flutter/foundation.dart';
import '../models/goal.dart';

class GoalStore extends ChangeNotifier {
  final List<Goal> _goals = [
    Goal(
      id: 1,
      name: 'Emergency Fund',
      targetAmount: 20000,
      savedAmount: 8500,
      deadline: DateTime.now().add(
        const Duration(days: 120),
      ),
    ),
    Goal(
      id: 2,
      name: 'New Laptop',
      targetAmount: 60000,
      savedAmount: 18000,
      deadline: DateTime.now().add(
        const Duration(days: 240),
      ),
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
    required double targetAmount,
    required DateTime deadline,
  }) {
    _goals.add(
      Goal(
        id: DateTime.now().millisecondsSinceEpoch,
        name: name,
        targetAmount: targetAmount,
        savedAmount: 0,
        deadline: deadline,
      ),
    );

    notifyListeners();
  }

  void addSavings(int goalId, double amount) {
    final index = _goals.indexWhere(
      (goal) => goal.id == goalId,
    );

    if (index == -1) return;

    final goal = _goals[index];

    _goals[index] = Goal(
      id: goal.id,
      name: goal.name,
      targetAmount: goal.targetAmount,
      savedAmount: goal.savedAmount + amount,
      deadline: goal.deadline,
    );

    notifyListeners();
  }
}