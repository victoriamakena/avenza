import 'package:flutter/foundation.dart';
import '../models/transaction.dart';
import '../services/savings_service.dart';

class SavingsStore extends ChangeNotifier {
  final SavingsService _savingsService = SavingsService();

  List<SavingsTransaction> _transactions = [];
  bool isLoading = false;
  String? errorMessage;

  List<SavingsTransaction> get transactions => List.unmodifiable(_transactions);

  double get totalSaved {
    return _transactions.fold(
      0,
      (total, transaction) => total + (transaction.isDeposit ? transaction.amount : 0),
    );
  }

  Future<void> fetchTransactions() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final json = await _savingsService.getTransactions();
      _transactions = json.map((j) => SavingsTransaction.fromJson(j)).toList();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}