import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_tracker/data/repositories/transaction_repository.dart';

import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository _repository = TransactionRepository();

  TransactionBloc() : super(TransactionInitial()) {
    on<LoadTransactions>((event, emit) {
      emit(TransactionLoading());
      try {
        final data = _repository.getAllTransactions();
        emit(TransactionLoaded(data));
      } catch (e) {
        print("[ERROR] LoadTransactions: $e");
        emit(const TransactionError('Failed to load transactions.'));
      }
    });

    on<AddTransaction>((event, emit) async {
      try {
        await _repository.addTransaction(event.transaction);
        add(LoadTransactions());
      } catch (e) {
        print("[ERROR] AddTransaction: $e");
      }
    });

    on<UpdateTransaction>((event, emit) async {
      try {
        await _repository.updateTransaction(
          event.key,                     // No change, 'key' is correct
          event.updatedTransaction,     // ✅ Changed from event.updated to event.updatedTransaction
        );
        add(LoadTransactions());
      } catch (e) {
        print("[ERROR] UpdateTransaction: $e");
      }
    });

    on<DeleteTransaction>((event, emit) async {
      try {
        await _repository.deleteTransaction(event.key);
        add(LoadTransactions());
      } catch (e) {
        print("[ERROR] DeleteTransaction: $e");
      }
    });
  }
}
