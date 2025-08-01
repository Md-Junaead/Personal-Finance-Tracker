import 'package:finance_tracker/data/datasources/category_local_datasource.dart';
import 'package:finance_tracker/data/models/category_model.dart';

class CategoryRepository {
  final CategoryLocalDatasource _localDatasource = CategoryLocalDatasource();

  List<CategoryModel> getAllCategories() {
    return _localDatasource.getAllCategories();
  }

  Future<void> addCategory(CategoryModel model) {
    return _localDatasource.addCategory(model);
  }

  Future<void> updateCategory(int key, CategoryModel model) {
    return _localDatasource.updateCategory(key, model);
  }

  Future<void> deleteCategory(int key) {
    return _localDatasource.deleteCategory(key);
  }
}
