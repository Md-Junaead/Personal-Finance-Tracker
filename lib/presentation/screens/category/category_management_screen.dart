import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_tracker/logic/blocs/category/category_bloc.dart';
import 'package:finance_tracker/logic/blocs/category/category_event.dart';
import 'package:finance_tracker/logic/blocs/category/category_state.dart';

class CategoryManagementScreen extends StatefulWidget {
  const CategoryManagementScreen({super.key});

  @override
  State<CategoryManagementScreen> createState() =>
      _CategoryManagementScreenState();
}

class _CategoryManagementScreenState extends State<CategoryManagementScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _isIncome = false;

  void _showAddCategoryDialog({String? initial, int? id}) {
    if (initial != null) _nameController.text = initial;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(id == null ? "Add Category" : "Edit Category"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Category Name'),
            ),
            SwitchListTile(
              title: const Text("Is Income?"),
              value: _isIncome,
              onChanged: (val) => setState(() => _isIncome = val),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final name = _nameController.text.trim();
              if (name.isEmpty) return;

              if (id == null) {
                context.read<CategoryBloc>().add(AddCategory(name, _isIncome));
              } else {
                context
                    .read<CategoryBloc>()
                    .add(UpdateCategory(id, name, _isIncome));
              }

              _nameController.clear();
              Navigator.of(context).pop();
            },
            child: Text(id == null ? "Add" : "Update"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manage Categories")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCategoryDialog(),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoaded) {
            return ListView.builder(
              itemCount: state.categories.length,
              itemBuilder: (_, index) {
                final cat = state.categories[index];
                return ListTile(
                  title: Text(cat.name),
                  leading: Icon(
                    cat.isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                    color: cat.isIncome ? Colors.green : Colors.red,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showAddCategoryDialog(
                          initial: cat.name,
                          id: cat.id,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context
                              .read<CategoryBloc>()
                              .add(DeleteCategory(cat.id));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("Error loading categories"));
          }
        },
      ),
    );
  }
}
