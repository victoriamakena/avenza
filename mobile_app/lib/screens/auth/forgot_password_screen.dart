import 'package:flutter/material.dart';

import '../../widgets/avenza_button.dart';
import '../../widgets/avenza_text_field.dart';

class ForgotPasswordScreen
    extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {

  final emailController =
      TextEditingController();

  bool loading = false;

  Future<void> _sendResetLink() async {
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
          'If the email exists, a reset link has been sent.',
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reset password',
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              const Text(
                'Forgot your password?',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Enter your email address and we will send you instructions to reset your password.',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 30),

              AvenzaTextField(
                label: 'Email',
                controller: emailController,
                keyboardType:
                    TextInputType.emailAddress,
                prefixIcon:
                    Icons.email_outlined,
              ),

              const SizedBox(height: 24),

              AvenzaButton(
                text: 'Send Reset Link',
                loading: loading,
                onPressed:
                    _sendResetLink,
              ),
            ],
          ),
        ),
      ),
    );
  }
}