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
