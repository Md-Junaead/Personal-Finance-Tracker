import 'package:equatable/equatable.dart';
import 'package:finance_tracker/data/models/budget_model.dart';

abstract class BudgetEvent extends Equatable {
  const BudgetEvent();

  @override
  List<Object?> get props => [];
}

class LoadBudget extends BudgetEvent {}

class SetBudget extends BudgetEvent {
  final BudgetModel budget;

  const SetBudget(this.budget);

  @override
  List<Object?> get props => [budget];
}

// ✅ Fix: Add this to support notification toggle
class ToggleBudgetNotification extends BudgetEvent {
  final bool enabled;

  const ToggleBudgetNotification(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

// ✅ Fix: Add this to support budget update
class UpdateBudgetLimit extends BudgetEvent {
  final double limit;

  const UpdateBudgetLimit(this.limit);

  @override
  List<Object?> get props => [limit];
}
