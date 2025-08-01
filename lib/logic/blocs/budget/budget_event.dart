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
