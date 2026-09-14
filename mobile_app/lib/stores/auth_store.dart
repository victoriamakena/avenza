import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthStore extends ChangeNotifier {
  final AuthService _authService = AuthService();

  AppUser? _user;
  bool _loading = false;
  String? errorMessage;

  AppUser? get user => _user;
  bool get isLoggedIn => _user != null;
  bool get loading => _loading;

  Future<bool> login(String email, String password) async {
    _loading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final json = await _authService.login(email, password);
      _user = AppUser.fromJson(json);
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    notifyListeners();
  }
}