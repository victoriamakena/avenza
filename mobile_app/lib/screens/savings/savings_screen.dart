import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../stores/savings_store.dart';
import '../../theme/app_colors.dart';
import '../../widgets/section_title.dart';
import '../../widgets/transaction_tile.dart';
import '../../widgets/avenza_button.dart';

class SavingsScreen extends StatelessWidget {
  const SavingsScreen({super.key});

  void _showAddSavings(BuildContext context) {
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Savings',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Record a savings contribution for this prototype.',
                style: TextStyle(
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixText: 'KSh ',
                ),
              ),
              const SizedBox(height: 20),
              AvenzaButton(
                text: 'Add Savings',
                onPressed: () {
                  final amount =
                      double.tryParse(controller.text);

                  if (amount == null || amount <= 0) return;

                  context.read<SavingsStore>().addDeposit(
                        amount,
                        'Manual savings',
                      );

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<SavingsStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Savings'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Card(
              color: AppColors.primary,
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Saved',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'KSh ${store.totalSaved.toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Every small contribution counts.',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            AvenzaButton(
              text: 'Add Savings',
              icon: Icons.add,
              onPressed: () => _showAddSavings(context),
            ),

            const SizedBox(height: 28),

            const SectionTitle(
              title: 'Recent Activity',
            ),

            const SizedBox(height: 10),

            if (store.transactions.isEmpty)
              const Text('No savings activity yet.')
            else
              ...store.transactions.map(
                (transaction) =>
                    TransactionTile(transaction: transaction),
              ),
          ],
        ),
      ),
    );
  }
}