import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/storage_service.dart';
import '../../stores/auth_store.dart';
import '../auth/login_screen.dart';
import '../home/home_screen.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _startApp();
  }

  Future<void> _startApp() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (!mounted) return;

    final onboardingComplete =
        await StorageService.isOnboardingComplete();

    if (!mounted) return;

    if (!onboardingComplete) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const OnboardingScreen(),
        ),
      );

      return;
    }

    final authStore = context.read<AuthStore>();

    final authenticated =
        await authStore.restoreSession();

    if (!mounted) return;

    if (authenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons.savings_outlined,
              size: 80,
              color: Color(0xFF1E3A8A),
            ),

            SizedBox(height: 20),

            Text(
              'Avenza',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A),
              ),
            ),

            SizedBox(height: 8),

            Text(
              'Save for what matters.',
              style: TextStyle(
                color: Color(0xFF6B7280),
              ),
            ),

            SizedBox(height: 32),

            SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}