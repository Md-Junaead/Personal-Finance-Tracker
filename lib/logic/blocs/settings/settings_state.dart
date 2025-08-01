import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {}

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
