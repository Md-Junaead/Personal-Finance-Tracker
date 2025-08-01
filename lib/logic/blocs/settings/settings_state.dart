import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {
  final bool isDarkMode; // ✅ Added
  final String currency; // ✅ Added

  const SettingsInitial({this.isDarkMode = false, this.currency = '৳'}); // ✅ Added constructor with defaults

  @override
  List<Object?> get props => [isDarkMode, currency]; // ✅ Updated to match fields
}

class SettingsLoaded extends SettingsState {
  final bool isDarkMode;
  final String currency;

  const SettingsLoaded({
    required this.isDarkMode,
    required this.currency,
  });

  @override
  List<Object?> get props => [isDarkMode, currency];
}
