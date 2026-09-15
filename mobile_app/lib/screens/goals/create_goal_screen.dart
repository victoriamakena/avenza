import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../stores/goal_store.dart';
import '../../widgets/avenza_button.dart';
import '../../widgets/avenza_text_field.dart';

class CreateGoalScreen extends StatefulWidget {
  const CreateGoalScreen({super.key});

  @override
  State<CreateGoalScreen> createState() => _CreateGoalScreenState();
}

class _CreateGoalScreenState extends State<CreateGoalScreen> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  DateTime? selectedDate;

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
      initialDate: DateTime.now().add(const Duration(days: 90)),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  void _createGoal() {
    if (nameController.text.isEmpty || amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a goal name and target amount.'),
        ),
      );
      return;
    }

    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please choose a target date.')),
      );
      return;
    }

    final amount = double.tryParse(amountController.text);

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid target amount.')),
      );
      return;
    }

    context.read<GoalStore>().addGoal(
          name: nameController.text.trim(),
          description: descriptionController.text.trim(),
          targetAmount: amount,
          targetDate: selectedDate!,
          category: 'other',
        );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Goal created successfully.')),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a goal'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What are you saving for?',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Give your dream a clear target and make it easier to work towards.',
              style: TextStyle(color: Color(0xFF6B7280)),
            ),

            const SizedBox(height: 28),

            AvenzaTextField(
              label: 'Goal name',
              hint: 'e.g. Emergency fund',
              controller: nameController,
              prefixIcon: Icons.flag_outlined,
            ),

            const SizedBox(height: 18),

            AvenzaTextField(
              label: 'Target amount (KSh)',
              hint: 'e.g. 20000',
              controller: amountController,
              keyboardType: TextInputType.number,
              prefixIcon: Icons.payments_outlined,
            ),

            const SizedBox(height: 18),

            AvenzaTextField(
              label: 'Description',
              hint: 'Why is this goal important to you?',
              controller: descriptionController,
              prefixIcon: Icons.notes_outlined,
            ),

            const SizedBox(height: 18),

            InkWell(
              onTap: _selectDate,
              borderRadius: BorderRadius.circular(14),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Target date',
                  prefixIcon: Icon(Icons.calendar_today_outlined),
                ),
                child: Text(
                  selectedDate == null
                      ? 'Choose a date'
                      : '${selectedDate!.day}/'
                          '${selectedDate!.month}/'
                          '${selectedDate!.year}',
                  style: TextStyle(
                    color: selectedDate == null
                        ? const Color(0xFF6B7280)
                        : const Color(0xFF111827),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            AvenzaButton(
              text: 'Create Goal',
              icon: Icons.add,
              onPressed: _createGoal,
            ),
          ],
        ),
      ),
    );
  }
}