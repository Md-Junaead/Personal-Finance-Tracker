import 'package:finance_tracker/data/datasources/budget_local_datasource.dart';
import 'package:finance_tracker/data/models/budget_model.dart';

class BudgetRepository {
  final BudgetLocalDatasource _localDatasource = BudgetLocalDatasource();

  BudgetModel? getBudget() {
    return _localDatasource.getBudget();
  }

  Future<void> setBudget(BudgetModel model) {
    return _localDatasource.setBudget(model);
  }
}
