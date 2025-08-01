import 'package:equatable/equatable.dart';
import 'package:finance_tracker/data/models/transaction_model.dart';

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

class UpdateTransaction extends TransactionEvent {
  final int key;
  final TransactionModel updated;
  const UpdateTransaction(this.key, this.updated);

  @override
  List<Object?> get props => [key, updated];
}

class DeleteTransaction extends TransactionEvent {
  final int key;
  const DeleteTransaction(this.key);

  @override
  List<Object?> get props => [key];
}
