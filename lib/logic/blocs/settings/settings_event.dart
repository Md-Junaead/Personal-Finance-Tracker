// lib/logic/blocs/settings/settings_event.dart

import 'package:equatable/equatable.dart';
import 'package:finance_tracker/data/models/settings_model.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettings extends SettingsEvent {}

class UpdateSettings extends SettingsEvent {
  final SettingsModel settings;

  const UpdateSettings(this.settings);

  @override
  List<Object?> get props => [settings];
}

class ResetSettings extends SettingsEvent {}


// ✅ Added: Event for toggling dark mode
class ToggleDarkMode extends SettingsEvent {} // <-- Added

// ✅ Added: Event for changing currency
class ChangeCurrency extends SettingsEvent { // <-- Added
  final String currency;

  const ChangeCurrency(this.currency);

  @override
  List<Object?> get props => [currency];
}

// ✅ Added: Event for resetting app data
class ResetApp extends SettingsEvent {} // <-- Added
