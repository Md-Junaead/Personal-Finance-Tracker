import 'package:finance_tracker/data/datasources/transaction_local_datasource.dart';
import 'package:finance_tracker/data/models/transaction_model.dart';

class TransactionRepository {
  final TransactionLocalDatasource _localDatasource = TransactionLocalDatasource();

  List<TransactionModel> getAllTransactions() {
    return _localDatasource.getAllTransactions();
  }

  Future<void> addTransaction(TransactionModel model) {
    return _localDatasource.addTransaction(model);
  }

  Future<void> updateTransaction(int key, TransactionModel model) {
    return _localDatasource.updateTransaction(key, model);
  }

  Future<void> deleteTransaction(int key) {
    return _localDatasource.deleteTransaction(key);
  }
}
