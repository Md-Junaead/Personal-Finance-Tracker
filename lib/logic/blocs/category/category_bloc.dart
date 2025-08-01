import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_tracker/data/repositories/category_repository.dart';
import 'package:finance_tracker/data/models/category_model.dart';

import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _repository = CategoryRepository();

  CategoryBloc() : super(CategoryInitial()) {
    on<LoadCategories>((event, emit) {
      emit(CategoryLoading());
      try {
        final data = _repository.getAllCategories();
        emit(CategoryLoaded(data));
      } catch (e) {
        print("[ERROR] LoadCategories: $e");
        emit(const CategoryError("Failed to load categories"));
      }
    });

    on<AddCategory>((event, emit) async {
      await _repository.addCategory(event.category);
      add(LoadCategories());
    });

    on<UpdateCategory>((event, emit) async {
      await _repository.updateCategory(event.key, event.updated);
      add(LoadCategories());
    });

    on<DeleteCategory>((event, emit) async {
      await _repository.deleteCategory(event.key);
      add(LoadCategories());
    });
  }
}
