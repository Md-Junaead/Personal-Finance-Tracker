import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_tracker/logic/blocs/budget/budget_bloc.dart';
import 'package:finance_tracker/logic/blocs/budget/budget_event.dart';
import 'package:finance_tracker/logic/blocs/budget/budget_state.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final TextEditingController _budgetController = TextEditingController();

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Budget Settings")),
      body: BlocBuilder<BudgetBloc, BudgetState>(
        builder: (context, state) {
          if (state is BudgetLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BudgetLoaded) {
            _budgetController.text = state.budget.monthlyLimit.toString();

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _budgetController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Monthly Budget",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text("Notifications"),
                      const Spacer(),
                      Switch(
                        value: state.budget.notificationsEnabled,
                        onChanged: (val) {
                          context.read<BudgetBloc>().add(
                                ToggleBudgetNotification(val),
                              );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final input = _budgetController.text.trim();
                      if (input.isEmpty) return;
                      final amount = double.tryParse(input);
                      if (amount == null || amount < 0) return;

                      context
                          .read<BudgetBloc>()
                          .add(UpdateBudgetLimit(amount));

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Budget updated successfully"),
                        ),
                      );
                    },
                    child: const Text("Set Budget"),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("Error loading budget info."));
          }
        },
      ),
    );
  }
}
