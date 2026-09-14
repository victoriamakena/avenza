import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:mobile_app/main.dart';
import 'package:mobile_app/stores/app_state.dart';
import 'package:mobile_app/stores/auth_store.dart';
import 'package:mobile_app/stores/goal_store.dart';
import 'package:mobile_app/stores/savings_store.dart';
import 'package:mobile_app/stores/reward_store.dart';
import 'package:mobile_app/stores/learn_store.dart';

void main() {
  testWidgets('App boots and shows the splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(
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

    await tester.pump();

    expect(find.text('Avenza'), findsOneWidget);
  });
}