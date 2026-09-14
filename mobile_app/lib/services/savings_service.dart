import 'api_service.dart';

class SavingsService {
  final ApiService api = ApiService.instance;

  Future<List<dynamic>> getTransactions() async {
    final data = await api.get('/transactions');
    return data['transactions']?['data'] ?? [];
  }
}