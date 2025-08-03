import 'package:hive/hive.dart';

part 'category_model.g.dart';

@HiveType(typeId: 1)
class CategoryModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  bool isIncome;

  CategoryModel({
    required this.name,
    required this.isIncome,
  });

  // ✅ Use HiveObject key as ID
  int get id => key as int; // ✅ Updated: now returns the Hive key as an int
}
