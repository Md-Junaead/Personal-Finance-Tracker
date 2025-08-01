import 'package:equatable/equatable.dart';
import 'package:finance_tracker/data/models/category_model.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadCategories extends CategoryEvent {}

class AddCategory extends CategoryEvent {
  final CategoryModel category;

  const AddCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class UpdateCategory extends CategoryEvent {
  final int key;
  final CategoryModel updated;

  const UpdateCategory(this.key, this.updated);

  @override
  List<Object?> get props => [key, updated];
}

class DeleteCategory extends CategoryEvent {
  final int key;

  const DeleteCategory(this.key);

  @override
  List<Object?> get props => [key];
}
