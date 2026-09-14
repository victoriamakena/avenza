import 'package:flutter/material.dart';

import '../../widgets/avenza_button.dart';
import '../../widgets/avenza_text_field.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {

  final nameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool loading = false;

  Future<void> _register() async {
    setState(() {
      loading = true;
    });

    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) return;

    setState(() {
      loading = false;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          'Account created. Please log in.',
        ),
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create account'),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'Start your Avenza journey',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Create an account and start building better saving habits.',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                ),
              ),

              const SizedBox(height: 32),

              AvenzaTextField(
                label: 'Full name',
                controller: nameController,
                prefixIcon:
                    Icons.person_outline,
              ),

              const SizedBox(height: 18),

              AvenzaTextField(
                label: 'Email',
                controller: emailController,
                keyboardType:
                    TextInputType.emailAddress,
                prefixIcon:
                    Icons.email_outlined,
              ),

              const SizedBox(height: 18),

              AvenzaTextField(
                label: 'Password',
                controller:
                    passwordController,
                obscureText: true,
                prefixIcon:
                    Icons.lock_outline,
              ),

              const SizedBox(height: 28),

              AvenzaButton(
                text: 'Create Account',
                loading: loading,
                onPressed: _register,
              ),

              const SizedBox(height: 20),

              const Text(
                'By creating an account, you agree to use Avenza as a savings and financial education prototype.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}