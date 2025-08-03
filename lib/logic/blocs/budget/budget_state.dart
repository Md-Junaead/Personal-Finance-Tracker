import 'package:equatable/equatable.dart';
import 'package:finance_tracker/data/models/budget_model.dart'; // Make sure this import is correct

abstract class BudgetState extends Equatable {
  const BudgetState();

  @override
  List<Object?> get props => [];
}

class BudgetInitial extends BudgetState {}

// ✅ ADDED: State for showing loading indicator
class BudgetLoading extends BudgetState {}

class BudgetLoaded extends BudgetState {
  final BudgetModel budget;

  const BudgetLoaded(this.budget);

  @override
  List<Object?> get props => [budget];
}

class BudgetError extends BudgetState {
  final String message;

  const BudgetError(this.message);

  @override
  List<Object?> get props => [message];
}
