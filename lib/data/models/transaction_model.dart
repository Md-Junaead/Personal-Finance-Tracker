class TransactionModel {
  final String id; // ✅ Added: Unique identifier for each transaction
  final double amount;
  final String category;
  final bool isIncome;
  final String note;
  final DateTime date;

  TransactionModel({
    required this.id, // ✅ Added: Make sure to pass `id` while creating the model
    required this.amount,
    required this.category,
    required this.isIncome,
    required this.note,
    required this.date,
  });

  // ✅ Added: Enables editing without mutating original object
  TransactionModel copyWith({
    double? amount,
    String? category,
    bool? isIncome,
    String? note,
  }) {
    return TransactionModel(
      id: id, // Preserve the same id
      amount: amount ?? this.amount,
      category: category ?? this.category,
      isIncome: isIncome ?? this.isIncome,
      note: note ?? this.note,
      date: date, // Keep original date
    );
  }
}
