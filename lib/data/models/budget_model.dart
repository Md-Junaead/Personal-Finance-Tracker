import 'package:hive/hive.dart';

part 'budget_model.g.dart';

@HiveType(typeId: 2)
class BudgetModel extends HiveObject {
  @HiveField(0)
  double monthlyLimit;

  @HiveField(1)
  bool notificationsEnabled;

  BudgetModel({
    required this.monthlyLimit,
    required this.notificationsEnabled,
  });
}
