import 'package:flutter/foundation.dart';
import '../models/goal.dart';
import '../services/goal_service.dart';

class GoalStore extends ChangeNotifier {
  final GoalService _goalService = GoalService();

  List<Goal> _goals = [];
  bool isLoading = false;
  String? errorMessage;

  List<Goal> get goals => List.unmodifiable(_goals);

  double get totalSaved {
    return _goals.fold(0, (total, goal) => total + goal.savedAmount);
  }

  String _iconFor(String? category) {
    switch (category) {
      case 'emergency':
        return '🛡️';
      case 'education':
        return '🎓';
      case 'electronics':
        return '💻';
      case 'travel':
        return '✈️';
      default:
        return '🎯';
    }
  }

  Goal _fromJson(Map<String, dynamic> json) {
    return Goal(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      targetAmount: double.parse(json['target_amount'].toString()),
      savedAmount: double.parse(json['current_amount'].toString()),
      targetDate: json['target_date'] != null
          ? DateTime.parse(json['target_date'])
          : DateTime.now().add(const Duration(days: 90)),
      icon: _iconFor(json['category']),
    );
  }

  Future<void> fetchGoals() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final goalsJson = await _goalService.getGoals();
      _goals = goalsJson.map((json) => _fromJson(json)).toList();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addGoal({
    required String name,
    required String description,
    required double targetAmount,
    required DateTime targetDate,
    String? category,
  }) async {
    try {
      final json = await _goalService.createGoal({
        'name': name,
        'description': description,
        'target_amount': targetAmount,
        'target_date': targetDate.toIso8601String().split('T').first,
        'category': category,
      });

      _goals.insert(0, _fromJson(json));
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> addSavings(int goalId, double amount) async {
    try {
      await _goalService.addSavings(goalId, amount);
      await fetchGoals();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}