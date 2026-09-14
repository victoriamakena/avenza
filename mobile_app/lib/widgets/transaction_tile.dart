import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../theme/app_colors.dart';

class TransactionTile extends StatelessWidget {
  final SavingsTransaction transaction;

  const TransactionTile({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: AppColors.lightSuccess,
        child: const Icon(
          Icons.arrow_downward,
          color: AppColors.emerald,
        ),
      ),
      title: Text(
        transaction.description,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        '${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
      ),
      trailing: Text(
        '+ KSh ${transaction.amount.toStringAsFixed(0)}',
        style: const TextStyle(
          color: AppColors.emerald,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}