import 'package:flutter/material.dart';

class AccessibilityScreen extends StatefulWidget {
  const AccessibilityScreen({super.key});

  @override
  State<AccessibilityScreen> createState() =>
      _AccessibilityScreenState();
}

class _AccessibilityScreenState
    extends State<AccessibilityScreen> {
  bool largeText = false;
  bool highContrast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accessibility'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Larger text'),
            subtitle: const Text(
              'Make important information easier to read.',
            ),
            value: largeText,
            onChanged: (value) {
              setState(() {
                largeText = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('High contrast'),
            subtitle: const Text(
              'Increase visual contrast for easier reading.',
            ),
            value: highContrast,
            onChanged: (value) {
              setState(() {
                highContrast = value;
              });
            },
          ),
          const ListTile(
            leading: Icon(Icons.language),
            title: Text('Language'),
            subtitle: Text(
              'English • Kiswahili coming in the next phase',
            ),
          ),
        ],
      ),
    );
  }
}