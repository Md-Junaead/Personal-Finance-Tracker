import 'package:equatable/equatable.dart';
import 'package:finance_tracker/data/models/transaction_model.dart'; // ✅ Import the model to use in event

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object?> get props => [];
}

class LoadTransactions extends TransactionEvent {}

class AddTransaction extends TransactionEvent {
  final TransactionModel transaction;

  const AddTransaction(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

// ✅ Updated: changed `id` type from String to int (Hive key)
class UpdateTransaction extends TransactionEvent {
  final TransactionModel updatedTransaction;
  final int key; // ✅ changed from String id to int key

  const UpdateTransaction(this.updatedTransaction, this.key); // ✅ updated constructor

  @override
  List<Object?> get props => [updatedTransaction, key]; // ✅ updated props
}

// ✅ Updated: changed `id` type from String to int (Hive key)
class DeleteTransaction extends TransactionEvent {
  final int key; // ✅ changed from String id to int key

  const DeleteTransaction(this.key); // ✅ updated constructor

  @override
  List<Object?> get props => [key]; // ✅ updated props
}
