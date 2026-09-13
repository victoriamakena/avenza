import 'package:flutter/material.dart';

import '../../services/storage_service.dart';
import '../auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({
    super.key,
  });

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends State<OnboardingScreen> {
  final PageController _controller =
      PageController();

  int _currentPage = 0;

  final List<OnboardingPage> pages = [
    OnboardingPage(
      icon: Icons.lightbulb_outline,
      title: 'Start with a dream',
      description:
          'Choose something important to you and turn it into a savings goal.',
    ),
    OnboardingPage(
      icon: Icons.savings_outlined,
      title: 'Save at your pace',
      description:
          'Build a consistent savings habit with simple progress tracking.',
    ),
    OnboardingPage(
      icon: Icons.school_outlined,
      title: 'Learn as you grow',
      description:
          'Get practical financial lessons that help you make better money decisions.',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  Future<void> _finish() async {
    await StorageService.setOnboardingComplete();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = pages[index];

                  return Padding(
                    padding:
                        const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 140,
                          height: 140,
                          decoration:
                              BoxDecoration(
                            color: const Color(
                              0xFFEFF6FF,
                            ),
                            borderRadius:
                                BorderRadius.circular(
                              70,
                            ),
                          ),
                          child: Icon(
                            page.icon,
                            size: 70,
                            color: const Color(
                              0xFF1E3A8A,
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        Text(
                          page.title,
                          textAlign:
                              TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 16),

                        Text(
                          page.description,
                          textAlign:
                              TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Color(
                              0xFF6B7280,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) {
                  final selected =
                      index == _currentPage;

                  return Container(
                    margin:
                        const EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    width: selected ? 24 : 8,
                    height: 8,
                    decoration:
                        BoxDecoration(
                      color: selected
                          ? const Color(
                              0xFF1E3A8A,
                            )
                          : const Color(
                              0xFFD1D5DB,
                            ),
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPage ==
                        pages.length - 1) {
                      _finish();
                    } else {
                      _controller.nextPage(
                        duration:
                            const Duration(
                          milliseconds: 300,
                        ),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                    _currentPage ==
                            pages.length - 1
                        ? 'Get Started'
                        : 'Next',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage {
  final IconData icon;
  final String title;
  final String description;

  OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
  });
}