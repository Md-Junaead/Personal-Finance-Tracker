import 'package:hive/hive.dart';
import 'package:finance_tracker/data/models/budget_model.dart';

class BudgetLocalDatasource {
  final _budgetBox = Hive.box<BudgetModel>('budget');

  BudgetModel? getBudget() {
    print("[DEBUG] Getting budget data");
    return _budgetBox.isNotEmpty ? _budgetBox.values.first : null;
  }

  Future<void> setBudget(BudgetModel budget) async {
    print("[DEBUG] Setting budget: ${budget.monthlyLimit}");
    if (_budgetBox.isNotEmpty) {
      await _budgetBox.putAt(0, budget);
    } else {
      await _budgetBox.add(budget);
    }
  }
}
