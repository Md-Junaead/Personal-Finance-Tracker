import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finance_tracker/logic/blocs/transaction/transaction_bloc.dart';
import 'package:finance_tracker/logic/blocs/transaction/transaction_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TransactionLoaded) {
            final income = state.transactions
                .where((t) => t.isIncome)
                .fold(0.0, (a, b) => a + b.amount);
            final expense = state.transactions
                .where((t) => !t.isIncome)
                .fold(0.0, (a, b) => a + b.amount);
            final balance = income - expense;

            return Column(
              children: [
                const SizedBox(height: 16),
                Text("Balance: \$${balance.toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Chip(label: Text("Income: \$${income.toStringAsFixed(2)}")),
                    Chip(label: Text("Expense: \$${expense.toStringAsFixed(2)}")),
                  ],
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => context.push('/report'),
                  child: const Text('View Report'),
                ),
                ElevatedButton(
                  onPressed: () => context.push('/list'),
                  child: const Text('View Transactions'),
                ),
              ],
            );
          } else {
            return const Center(child: Text("Something went wrong."));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
