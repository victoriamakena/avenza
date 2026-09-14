class SavingsTransaction {
  final int id;
  final double amount;
  final String type;
  final String description;
  final DateTime date;

  SavingsTransaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.description,
    required this.date,
  });

  bool get isDeposit => type == 'saving';

  factory SavingsTransaction.fromJson(Map<String, dynamic> json) {
    return SavingsTransaction(
      id: json['id'],
      amount: double.tryParse(json['amount'].toString()) ?? 0,
      type: json['type'] ?? 'deposit',
      description: json['description'] ?? '',
      date: DateTime.tryParse(json['created_at'].toString()) ?? DateTime.now(),
    );
  }
}