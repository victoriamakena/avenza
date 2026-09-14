import 'package:flutter/foundation.dart';
import '../models/transaction.dart';

class SavingsStore extends ChangeNotifier {
  final List<SavingsTransaction> _transactions = [
    SavingsTransaction(
      id: 1,
      amount: 1000,
      type: 'deposit',
      description: 'Weekly savings',
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    SavingsTransaction(
      id: 2,
      amount: 500,
      type: 'deposit',
      description: 'Goal contribution',
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  List<SavingsTransaction> get transactions =>
      List.unmodifiable(_transactions);

  double get totalSaved {
    return _transactions.fold(
      0,
      (total, transaction) =>
          total + (transaction.isDeposit ? transaction.amount : 0),
    );
  }

  void addDeposit(double amount, String description) {
    _transactions.insert(
      0,
      SavingsTransaction(
        id: DateTime.now().millisecondsSinceEpoch,
        amount: amount,
        type: 'deposit',
        description: description,
        date: DateTime.now(),
      ),
    );

    notifyListeners();
  }
}