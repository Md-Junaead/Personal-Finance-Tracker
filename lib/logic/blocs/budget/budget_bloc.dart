import 'package:flutter_bloc/flutter_bloc.dart';
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

    // ✅ Handle ToggleNotification
    on<ToggleBudgetNotification>((event, emit) async {
      final current = _repository.getBudget();
      if (current != null) {
        final updated = current.copyWith(notificationsEnabled: event.enabled);
        await _repository.setBudget(updated);
        emit(BudgetLoaded(updated));
      }
    });

    // ✅ Handle UpdateBudgetLimit
    on<UpdateBudgetLimit>((event, emit) async {
      final current = _repository.getBudget();
      if (current != null) {
        final updated = current.copyWith(monthlyLimit: event.limit);
        await _repository.setBudget(updated);
        emit(BudgetLoaded(updated));
      }
    });
  }
}
