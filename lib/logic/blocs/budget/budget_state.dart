import 'package:equatable/equatable.dart';
import 'package:finance_tracker/data/models/budget_model.dart';

abstract class BudgetState extends Equatable {
  const BudgetState();

  @override
  List<Object?> get props => [];
}

class BudgetInitial extends BudgetState {}

class BudgetLoaded extends BudgetState {
  final BudgetModel budget;

  const BudgetLoaded(this.budget);

  @override
  List<Object?> get props => [budget];
}
