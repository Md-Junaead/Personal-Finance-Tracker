import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finance_tracker/data/models/transaction_model.dart';
import 'package:finance_tracker/logic/blocs/transaction/transaction_bloc.dart';
import 'package:finance_tracker/logic/blocs/transaction/transaction_event.dart';
import 'package:uuid/uuid.dart'; // <-- ✅ Added for unique ID generation

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  bool _isIncome = false;
  String _category = 'General';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Transaction')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.isEmpty ? 'Enter amount' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                value: _category,
                items: const [
                  DropdownMenuItem(value: 'General', child: Text('General')),
                  DropdownMenuItem(value: 'Food', child: Text('Food')),
                  DropdownMenuItem(value: 'Bills', child: Text('Bills')),
                ],
                onChanged: (val) => setState(() => _category = val!),
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text("Income?"),
                value: _isIncome,
                onChanged: (val) => setState(() => _isIncome = val),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(labelText: 'Note'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final txn = TransactionModel(
                      id: const Uuid().v4(), // <-- ✅ Added this line to generate a unique ID
                      amount: double.parse(_amountController.text),
                      category: _category,
                      date: DateTime.now(),
                      note: _noteController.text,
                      isIncome: _isIncome,
                    );
                    context.read<TransactionBloc>().add(AddTransaction(txn));
                    context.go('/home');
                  }
                },
                child: const Text('Save'),
              ),
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
