import 'package:flutter/foundation.dart';
import '../models/user.dart';

class AuthStore extends ChangeNotifier {
  AppUser? _user;
  bool _loading = false;

  AppUser? get user => _user;
  bool get isLoggedIn => _user != null;
  bool get loading => _loading;

  Future<void> login(String email, String password) async {
    _loading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 700));

    _user = AppUser(
      id: 1,
      name: 'Victoria',
      email: email,
      phone: '+254700000000',
      xp: 240,
      rewardPoints: 120,
      streak: 6,
      emailVerified: true,
    );

    _loading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    _user = null;
    notifyListeners();
  }

  void setUser(AppUser user) {
    _user = user;
    notifyListeners();
  }
}