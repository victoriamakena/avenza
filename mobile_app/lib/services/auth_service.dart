import '../models/user.dart';
import 'api_service.dart';
import 'storage_service.dart';

class AuthService {
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await ApiService.post(
      '/auth/login',
      {
        'email': email,
        'password': password,
      },
    );

    if (response['token'] != null) {
      await StorageService.saveToken(response['token']);
    }

    return response;
  }

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    String? phone,
  }) async {
    final data = {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };

    if (phone != null && phone.isNotEmpty) {
      data['phone'] = phone;
    }

    return await ApiService.post(
      '/auth/register',
      data,
    );
  }

  static Future<Map<String, dynamic>> forgotPassword({
    required String email,
  }) async {
    return await ApiService.post(
      '/auth/forgot-password',
      {
        'email': email,
      },
    );
  }

  static Future<User> getCurrentUser() async {
    final token = await StorageService.getToken();

    if (token == null) {
      throw Exception('No authentication token found.');
    }

    final response = await ApiService.get(
      '/auth/me',
      token: token,
    );

    return User.fromJson(response['user']);
  }

  static Future<void> logout() async {
    final token = await StorageService.getToken();

    try {
      if (token != null) {
        await ApiService.post(
          '/auth/logout',
          {},
          token: token,
        );
      }
    } finally {
      await StorageService.removeToken();
    }
  }
}