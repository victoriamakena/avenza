import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/app_button.dart';
import '../../components/app_text_field.dart';
import '../../stores/auth_store.dart';
import 'verification_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authStore = context.read<AuthStore>();

    final success = await authStore.register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      password: _passwordController.text,
      passwordConfirmation:
          _confirmPasswordController.text,
    );

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => VerificationScreen(
            email: _emailController.text.trim(),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            authStore.error ?? 'Registration failed.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<AuthStore>().loading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create account'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Start your savings journey',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Create an Avenza account and start working towards your goals.',
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 28),

                  AppTextField(
                    label: 'Full name',
                    controller: _nameController,
                    prefixIcon: Icons.person_outline,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Enter your name.';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  AppTextField(
                    label: 'Email',
                    controller: _emailController,
                    keyboardType:
                        TextInputType.emailAddress,
                    prefixIcon: Icons.email_outlined,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Enter your email.';
                      }

                      if (!value.contains('@')) {
                        return 'Enter a valid email.';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  AppTextField(
                    label: 'Phone number',
                    hint: 'Optional',
                    controller: _phoneController,
                    keyboardType:
                        TextInputType.phone,
                    prefixIcon: Icons.phone_outlined,
                  ),

                  const SizedBox(height: 16),

                  AppTextField(
                    label: 'Password',
                    controller: _passwordController,
                    obscureText: true,
                    prefixIcon: Icons.lock_outline,
                    validator: (value) {
                      if (value == null ||
                          value.length < 8) {
                        return 'Password must be at least 8 characters.';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  AppTextField(
                    label: 'Confirm password',
                    controller:
                        _confirmPasswordController,
                    obscureText: true,
                    prefixIcon: Icons.lock_outline,
                    validator: (value) {
                      if (value !=
                          _passwordController.text) {
                        return 'Passwords do not match.';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 28),

                  AppButton(
                    text: 'Create Account',
                    loading: loading,
                    onPressed: _register,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}