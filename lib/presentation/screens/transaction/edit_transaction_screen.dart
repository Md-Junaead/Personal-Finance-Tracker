import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finance_tracker/data/models/transaction_model.dart';
import 'package:finance_tracker/logic/blocs/transaction/transaction_bloc.dart';
import 'package:finance_tracker/logic/blocs/transaction/transaction_event.dart';

class EditTransactionScreen extends StatefulWidget {
  final TransactionModel transaction;

  const EditTransactionScreen({
    super.key,
    required this.transaction, required index,
  });

  @override
  State<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  late final TextEditingController _amountController;
  late final TextEditingController _noteController;
  late String _category;
  late bool _isIncome;

  @override
  void initState() {
    _amountController =
        TextEditingController(text: widget.transaction.amount.toString());
    _noteController = TextEditingController(text: widget.transaction.note);
    _category = widget.transaction.category;
    _isIncome = widget.transaction.isIncome;
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Transaction")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Amount"),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _category,
              items: const [
                DropdownMenuItem(value: 'General', child: Text('General')),
                DropdownMenuItem(value: 'Food', child: Text('Food')),
                DropdownMenuItem(value: 'Bills', child: Text('Bills')),
              ],
              onChanged: (val) => setState(() => _category = val!),
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              value: _isIncome,
              onChanged: (val) => setState(() => _isIncome = val),
              title: const Text("Income?"),
            ),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(labelText: "Note"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final updated = widget.transaction.copyWith(
                  amount: double.tryParse(_amountController.text) ?? 0,
                  category: _category,
                  isIncome: _isIncome,
                  note: _noteController.text,
                );
                // Pass the transaction id here
                context.read<TransactionBloc>().add(
                  UpdateTransaction(widget.transaction.id as TransactionModel, updated as int),
                );
                context.go('/list');
              },
              child: const Text("Update"),
            ),
            TextButton(
              onPressed: () {
                // Pass the transaction id here for deletion
                context.read<TransactionBloc>().add(
                  DeleteTransaction(widget.transaction.id as int),
                );
                context.go('/list');
              },
              child: const Text("Delete"),
            ),
            TextButton(
              onPressed: () => context.pop(),
              child: const Text("Cancel"),
            )
          ],
        ),
      ),
    );
  }
}
