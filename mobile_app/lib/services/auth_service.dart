import 'api_service.dart';

class AuthService {
  final ApiService api = ApiService.instance;

  Future<Map<String, dynamic>> login(String email, String password) async {
    final data = await api.post('/auth/login', {
      'email': email,
      'password': password,
    });

    await api.saveToken(data['token']);
    return data['user'];
  }

  Future<Map<String, dynamic>> fetchUser() async {
    final data = await api.get('/auth/me');
    return data['user'];
  }

  Future<void> logout() async {
    try {
      await api.post('/auth/logout');
    } catch (_) {
      // Ignore — we're clearing local state regardless.
    }

    await api.clearToken();
  }
}