import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  bool _onboardingCompleted = false;
  bool _initialized = false;

  bool get onboardingCompleted => _onboardingCompleted;
  bool get initialized => _initialized;

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();

    _onboardingCompleted =
        prefs.getBool('onboarding_completed') ?? false;

    _initialized = true;

    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('onboarding_completed', true);

    _onboardingCompleted = true;

    notifyListeners();
  }

  Future<void> resetOnboarding() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('onboarding_completed', false);

    _onboardingCompleted = false;

    notifyListeners();
  }
}