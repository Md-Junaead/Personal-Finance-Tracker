import 'package:equatable/equatable.dart';
import 'package:finance_tracker/data/models/transaction_model.dart'; // ✅ Added: Import the model to use in event

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

// ✅ Updated: Now accepts both updated transaction and its ID
class UpdateTransaction extends TransactionEvent {
  final TransactionModel updatedTransaction;
  final String id;

  const UpdateTransaction(this.updatedTransaction, this.id);

  @override
  List<Object?> get props => [updatedTransaction, id];
}

class DeleteTransaction extends TransactionEvent {
  final String id;

  const DeleteTransaction(this.id);

  @override
  List<Object?> get props => [id];
}
