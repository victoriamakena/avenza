import 'package:flutter/material.dart';

import '../../navigation/app_navigation.dart';
import '../../widgets/avenza_button.dart';
import '../../theme/app_colors.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String? email;

  const VerifyEmailScreen({
    super.key,
    this.email,
  });

  @override
  State<VerifyEmailScreen> createState() =>
      _VerifyEmailScreenState();
}

class _VerifyEmailScreenState
    extends State<VerifyEmailScreen> {
  bool _sending = false;

  Future<void> _resendVerification() async {
    setState(() {
      _sending = true;
    });

    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) return;

    setState(() {
      _sending = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'A verification email has been sent.',
        ),
      ),
    );
  }

  void _continueToApp() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const AppNavigation(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 45),

            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: AppColors.lightPrimary,
                borderRadius: BorderRadius.circular(45),
              ),
              child: const Icon(
                Icons.mark_email_read_outlined,
                size: 48,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Check your email',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              widget.email == null
                  ? 'We sent a verification link to your email address.'
                  : 'We sent a verification link to ${widget.email}.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: AppColors.secondaryText,
              ),
            ),

            const SizedBox(height: 35),

            AvenzaButton(
              text: _sending
                  ? 'Sending...'
                  : 'Resend Verification Email',
              onPressed:
                  _sending ? null : _resendVerification,
            ),

            const SizedBox(height: 14),

            TextButton(
              onPressed: _continueToApp,
              child: const Text(
                'I have verified my email',
              ),
            ),

            const Spacer(),

            const Text(
              'Check your spam or junk folder if you cannot find the email.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.secondaryText,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}