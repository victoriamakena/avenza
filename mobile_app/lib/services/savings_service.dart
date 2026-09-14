import 'api_service.dart';

class SavingsService {
  final ApiService api;

  SavingsService(this.api);

  Future<List<dynamic>> getTransactions() async {
    // GET /api/savings/transactions
    return [];
  }

  Future<void> addSavings(
    Map<String, dynamic> data,
  ) async {
    // POST /api/savings
  }
}