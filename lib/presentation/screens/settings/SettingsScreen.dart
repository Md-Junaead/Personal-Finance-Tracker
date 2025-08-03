import 'package:finance_tracker/logic/blocs/settings/settings_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_tracker/logic/blocs/settings/settings_bloc.dart';
import 'package:finance_tracker/logic/blocs/settings/settings_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            if (state is SettingsInitial) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SwitchListTile(
                    title: const Text("Dark Mode"),
                    value: state.isDarkMode,
                    onChanged: (val) {
                      context.read<SettingsBloc>().add(ToggleDarkMode());
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: state.currency,
                    decoration: const InputDecoration(
                      labelText: "Currency",
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: "৳", child: Text("BDT (৳)")),
                      DropdownMenuItem(value: "₹", child: Text("INR (₹)")),
                      DropdownMenuItem(value: "\$", child: Text("USD (\$)")),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        context.read<SettingsBloc>().add(ChangeCurrency(val));
                      }
                    },
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.warning, color: Colors.white),
                    label: const Text("Reset App Data"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Reset App Data"),
                          content: const Text(
                              "This will permanently delete all your data. Are you sure?"),
                          actions: [
                            TextButton(
                              child: const Text("Cancel"),
                              onPressed: () => Navigator.pop(context, false),
                            ),
                            TextButton(
                              child: const Text("Reset"),
                              onPressed: () => Navigator.pop(context, true),
                            ),
                          ],
                        ),
                      );

                      if (confirmed == true) {
                        context.read<SettingsBloc>().add(ResetApp());
                      }
                    },
                  ),
                ],
              );
            } else {
              return const Center(child: Text("Loading settings..."));
            }
          },
        ),
      ),
    );
  }
}
