import 'package:finance_tracker/presentation/screens/budget/budget_screen.dart';
import 'package:finance_tracker/presentation/screens/category/category_management_screen.dart';
import 'package:finance_tracker/presentation/screens/home/home_screen.dart';
import 'package:finance_tracker/presentation/screens/report/ReportScreen.dart';
import 'package:finance_tracker/presentation/screens/settings/SettingsScreen.dart';
import 'package:finance_tracker/presentation/screens/splash/splash_screen.dart';
import 'package:finance_tracker/presentation/screens/transaction/add_transaction_screen.dart';
import 'package:finance_tracker/presentation/screens/transaction/edit_transaction_screen.dart';
import 'package:finance_tracker/presentation/screens/transaction/transaction_list_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
    GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
    GoRoute(path: '/add', builder: (_, __) => const AddTransactionScreen()),
    GoRoute(path: '/list', builder: (_, __) => const TransactionListScreen()),

    // ✅ Updated: Now receiving both transaction and index using a Map
    GoRoute(
      path: '/edit',
      builder: (_, state) {
        final data = state.extra as Map<String, dynamic>; // ✅ Added to extract map from extra
        return EditTransactionScreen(
          transaction: data['transaction'], // ✅ Pass transaction from map
          index: data['index'],               // ✅ Pass index from map
        );
      },
    ),

    GoRoute(path: '/budget', builder: (_, __) => const BudgetScreen()),
    GoRoute(path: '/report', builder: (_, __) => const ReportScreen()),
    GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
    GoRoute(path: '/categories', builder: (_, __) => const CategoryManagementScreen()),
  ],
);
