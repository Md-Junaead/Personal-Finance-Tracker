import 'package:finance_tracker/logic/blocs/budget/budget_event.dart';
import 'package:finance_tracker/logic/blocs/category/category_event.dart';
import 'package:finance_tracker/logic/blocs/settings/settings_event.dart';
import 'package:finance_tracker/logic/blocs/settings/settings_state.dart';
import 'package:finance_tracker/logic/blocs/transaction/transaction_event.dart';
import 'package:finance_tracker/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'logic/blocs/transaction/transaction_bloc.dart';
import 'logic/blocs/category/category_bloc.dart';
import 'logic/blocs/budget/budget_bloc.dart';
import 'logic/blocs/settings/settings_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register Hive adapters and open boxes here
  // Hive.registerAdapter(...);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TransactionBloc()..add(LoadTransactions())),
        BlocProvider(create: (_) => CategoryBloc()..add(LoadCategories())),
        BlocProvider(create: (_) => BudgetBloc()..add(LoadBudget())),
        BlocProvider(create: (_) => SettingsBloc()..add(LoadSettings())),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          final isDark = (state is SettingsInitial && state.isDarkMode);
          return MaterialApp(
            title: 'Personal Finance Tracker',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: isDark ? Brightness.dark : Brightness.light,
              primarySwatch: Colors.teal,
              scaffoldBackgroundColor:
                  isDark ? Colors.grey[900] : Colors.grey[100],
              appBarTheme: const AppBarTheme(
                elevation: 0,
                centerTitle: true,
              ),
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
