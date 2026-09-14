import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'stores/app_state.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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