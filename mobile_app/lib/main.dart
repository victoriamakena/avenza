import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'stores/app_state.dart';
import 'stores/auth_store.dart';
import 'stores/goal_store.dart';
import 'stores/savings_store.dart';
import 'stores/reward_store.dart';
import 'stores/learn_store.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => AuthStore()),
        ChangeNotifierProvider(create: (_) => GoalStore()),
        ChangeNotifierProvider(create: (_) => SavingsStore()),
        ChangeNotifierProvider(create: (_) => RewardStore()),
        ChangeNotifierProvider(create: (_) => LearnStore()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avenza',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}