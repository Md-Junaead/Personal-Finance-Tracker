import 'package:hive/hive.dart'; // ✅ Import Hive here

part 'transaction_model.g.dart'; // ✅ Reference to the generated part file

@HiveType(typeId: 0) // Optional but recommended if using Hive code generation
class TransactionModel {
  @HiveField(0)
  final String id; // Unique identifier for each transaction

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String note;

  @HiveField(5)
  final bool isIncome;

  TransactionModel({
    required this.id, // Must be passed when creating an instance
    required this.amount,
    required this.category,
    required this.isIncome,
    required this.note,
    required this.date,
  });

  // Enables copying with modifications without mutating original object
  TransactionModel copyWith({
    double? amount,
    String? category,
    bool? isIncome,
    String? note,
  }) {
    return TransactionModel(
      id: id, // Keep the same id to uniquely identify the transaction
      amount: amount ?? this.amount,
      category: category ?? this.category,
      isIncome: isIncome ?? this.isIncome,
      note: note ?? this.note,
      date: date, // Keep the original date
    );
  }
}
