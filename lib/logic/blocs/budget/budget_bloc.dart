import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_tracker/data/models/budget_model.dart';
import 'package:finance_tracker/data/repositories/budget_repository.dart';

import 'budget_event.dart';
import 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final BudgetRepository _repository = BudgetRepository();

  BudgetBloc() : super(BudgetInitial()) {
    on<LoadBudget>((event, emit) {
      final data = _repository.getBudget();
      if (data != null) {
        emit(BudgetLoaded(data));
      }
    });

    on<SetBudget>((event, emit) async {
      await _repository.setBudget(event.budget);
      emit(BudgetLoaded(event.budget));
    });
  }
}
