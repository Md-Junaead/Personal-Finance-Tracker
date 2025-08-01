import 'package:hive/hive.dart';
import 'package:finance_tracker/data/models/transaction_model.dart';

class TransactionLocalDatasource {
  final _transactionBox = Hive.box<TransactionModel>('transactions');

  List<TransactionModel> getAllTransactions() {
    print("[DEBUG] Getting all transactions");
    return _transactionBox.values.toList();
  }

  Future<void> addTransaction(TransactionModel model) async {
    print("[DEBUG] Adding transaction: ${model.toString()}");
    await _transactionBox.add(model);
  }

  Future<void> updateTransaction(int key, TransactionModel updated) async {
    print("[DEBUG] Updating transaction: $key → ${updated.toString()}");
    await _transactionBox.put(key, updated);
  }

  Future<void> deleteTransaction(int key) async {
    print("[DEBUG] Deleting transaction: $key");
    await _transactionBox.delete(key);
  }
}
