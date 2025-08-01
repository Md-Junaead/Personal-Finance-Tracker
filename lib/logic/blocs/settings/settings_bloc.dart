import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_tracker/data/repositories/settings_repository.dart';
import 'package:finance_tracker/data/models/settings_model.dart';

import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _repository = SettingsRepository();

  SettingsBloc() : super(SettingsInitial()) {
    on<LoadSettings>((event, emit) {
      final data = _repository.getSettings();
      emit(SettingsLoaded(
        isDarkMode: data.isDarkMode,
        currency: data.currency,
      ));
    });

    on<UpdateSettings>((event, emit) async {
      await _repository.updateSettings(event.settings);
      emit(SettingsLoaded(
        isDarkMode: event.settings.isDarkMode,
        currency: event.settings.currency,
      ));
    });

    on<ResetSettings>((event, emit) async {
      await _repository.resetSettings();
      emit(const SettingsLoaded(isDarkMode: false, currency: 'USD'));
    });
  }
}
