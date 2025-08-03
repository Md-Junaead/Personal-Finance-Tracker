import 'package:finance_tracker/data/datasources/budget_local_datasource.dart';
import 'package:finance_tracker/data/models/budget_model.dart';

class BudgetRepository {
  // Using singleton datasource instance
  final BudgetLocalDatasource _localDatasource = BudgetLocalDatasource();

  /// ✅ Get the stored BudgetModel from local Hive storage
  BudgetModel? getBudget() {
    return _localDatasource.getBudget();
  }

  /// ✅ Save the updated BudgetModel to local Hive storage
  Future<void> setBudget(BudgetModel model) {
    return _localDatasource.setBudget(model);
  }

  // 🔧 No other logic is required here unless you abstract update/toggle further
}
