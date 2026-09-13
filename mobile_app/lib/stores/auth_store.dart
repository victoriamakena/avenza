import 'package:flutter/foundation.dart';

import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';

class AuthStore extends ChangeNotifier {
  User? _user;

  bool _loading = false;

  String? _error;

  User? get user => _user;

  bool get loading => _loading;

  String? get error => _error;

  bool get isAuthenticated => _user != null;

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _error = null;

    try {
      final response = await AuthService.login(
        email: email,
        password: password,
      );

      if (response['user'] != null) {
        _user = User.fromJson(response['user']);
      } else {
        _user = await AuthService.getCurrentUser();
      }

      notifyListeners();

      return true;
    } catch (e) {
      _error = e.toString();

      notifyListeners();

      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    String? phone,
  }) async {
    _setLoading(true);
    _error = null;

    try {
      await AuthService.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        phone: phone,
      );

      notifyListeners();

      return true;
    } catch (e) {
      _error = e.toString();

      notifyListeners();

      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> restoreSession() async {
    _setLoading(true);
    _error = null;

    try {
      final token = await StorageService.getToken();

      if (token == null) {
        return false;
      }

      _user = await AuthService.getCurrentUser();

      notifyListeners();

      return true;
    } catch (_) {
      await StorageService.removeToken();

      _user = null;

      notifyListeners();

      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    await AuthService.logout();

    _user = null;
    _error = null;

    notifyListeners();
  }

  void clearError() {
    _error = null;

    notifyListeners();
  }

  void _setLoading(bool value) {
    _loading = value;

    notifyListeners();
  }
}