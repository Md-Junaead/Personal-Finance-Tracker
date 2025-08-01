import 'package:hive/hive.dart';
import 'package:finance_tracker/data/models/category_model.dart';

class CategoryLocalDatasource {
  final _categoryBox = Hive.box<CategoryModel>('categories');

  List<CategoryModel> getAllCategories() {
    print("[DEBUG] Getting all categories");
    return _categoryBox.values.toList();
  }

  Future<void> addCategory(CategoryModel category) async {
    print("[DEBUG] Adding category: ${category.name}");
    await _categoryBox.add(category);
  }

  Future<void> updateCategory(int key, CategoryModel updated) async {
    print("[DEBUG] Updating category: $key");
    await _categoryBox.put(key, updated);
  }

  Future<void> deleteCategory(int key) async {
    print("[DEBUG] Deleting category: $key");
    await _categoryBox.delete(key);
  }
}
