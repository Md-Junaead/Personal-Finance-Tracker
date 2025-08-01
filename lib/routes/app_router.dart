import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
    GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
    GoRoute(path: '/add', builder: (_, __) => const AddTransactionScreen()),
    GoRoute(path: '/list', builder: (_, __) => const TransactionListScreen()),
    GoRoute(path: '/edit', builder: (_, __) => const EditTransactionScreen()),
    GoRoute(path: '/budget', builder: (_, __) => const BudgetScreen()),
    GoRoute(path: '/report', builder: (_, __) => const ReportScreen()),
    GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
    GoRoute(path: '/categories', builder: (_, __) => const CategoryManagementScreen()),
  ],
);
