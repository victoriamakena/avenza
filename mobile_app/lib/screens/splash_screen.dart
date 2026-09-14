import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stores/app_state.dart';
import 'auth/login_screen.dart';
import 'onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  Future<void> _initialize() async {
    final appState =
        context.read<AppState>();

    await appState.initialize();

    if (!mounted) return;

    if (appState.onboardingCompleted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const OnboardingScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A8A),
                borderRadius:
                    BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.savings_outlined,
                color: Colors.white,
                size: 50,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Avenza',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Save for what matters.',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 40),

            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}