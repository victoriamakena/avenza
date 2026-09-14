import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../stores/app_state.dart';
import '../auth/register_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends State<OnboardingScreen> {

  final PageController _controller =
      PageController();

  int _currentPage = 0;

  final pages = const [
    _OnboardingData(
      icon: Icons.flag_outlined,
      title: 'Save for what matters',
      description:
          'Turn your dreams into clear savings goals and take small steps toward them.',
    ),
    _OnboardingData(
      icon: Icons.trending_up,
      title: 'Build healthy money habits',
      description:
          'Save consistently, track your progress and understand how your money habits grow.',
    ),
    _OnboardingData(
      icon: Icons.school_outlined,
      title: 'Learn while you save',
      description:
          'Learn simple financial skills that help you make better everyday money decisions.',
    ),
  ];

  Future<void> _finish() async {
    await context
        .read<AppState>()
        .completeOnboarding();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const RegisterScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.all(24),
          child: Column(
            children: [
              Align(
                alignment:
                    Alignment.centerRight,
                child: TextButton(
                  onPressed: _finish,
                  child: const Text('Skip'),
                ),
              ),

              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder:
                      (context, index) {
                    final item = pages[index];

                    return Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 130,
                          width: 130,
                          decoration:
                              BoxDecoration(
                            color: const Color(
                              0xFFDBEAFE,
                            ),
                            borderRadius:
                                BorderRadius.circular(
                              35,
                            ),
                          ),
                          child: Icon(
                            item.icon,
                            size: 70,
                            color: const Color(
                              0xFF1E3A8A,
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        Text(
                          item.title,
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
                          item.description,
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
                    return AnimatedContainer(
                      duration:
                          const Duration(
                        milliseconds: 250,
                      ),
                      margin:
                          const EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                      height: 8,
                      width: index ==
                              _currentPage
                          ? 28
                          : 8,
                      decoration:
                          BoxDecoration(
                        color: index ==
                                _currentPage
                            ? const Color(
                                0xFF1E3A8A,
                              )
                            : const Color(
                                0xFFD1D5DB,
                              ),
                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPage <
                        pages.length - 1) {
                      _controller.nextPage(
                        duration:
                            const Duration(
                          milliseconds: 300,
                        ),
                        curve:
                            Curves.easeInOut,
                      );
                    } else {
                      _finish();
                    }
                  },
                  child: Text(
                    _currentPage ==
                            pages.length - 1
                        ? 'Get Started'
                        : 'Continue',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingData {
  final IconData icon;
  final String title;
  final String description;

  const _OnboardingData({
    required this.icon,
    required this.title,
    required this.description,
  });
}