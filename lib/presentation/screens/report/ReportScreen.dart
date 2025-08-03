import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_tracker/logic/blocs/transaction/transaction_bloc.dart';
import 'package:finance_tracker/logic/blocs/transaction/transaction_state.dart';
import 'package:finance_tracker/data/models/transaction_model.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Report")),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TransactionLoaded) {
            final transactions = state.transactions;

            final income = transactions
                .where((t) => t.isIncome == true) // ✅ category is String; use isIncome field
                .fold<double>(0, (sum, t) => sum + t.amount); // ✅ Line 23 fixed

            final expense = transactions
                .where((t) => t.isIncome == false) // ✅ Line 26 fixed
                .fold<double>(0, (sum, t) => sum + t.amount);

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Income vs Expense",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  AspectRatio(
                    aspectRatio: 1.5,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            color: Colors.green,
                            value: income,
                            title: 'Income',
                          ),
                          PieChartSectionData(
                            color: Colors.red,
                            value: expense,
                            title: 'Expense',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    "Category Breakdown",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: _buildCategoryBreakdown(transactions),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("Error loading report."));
          }
        },
      ),
    );
  }

  List<Widget> _buildCategoryBreakdown(List<TransactionModel> transactions) {
    final Map<String, double> categoryTotals = {};
    for (var t in transactions) {
      categoryTotals[t.category] = (categoryTotals[t.category] ?? 0) + t.amount; // ✅ Line 84 fixed
    }
    return categoryTotals.entries
        .map((entry) => ListTile(
              title: Text(entry.key),
              trailing: Text("৳${entry.value.toStringAsFixed(2)}"),
            ))
        .toList();
  }
}
