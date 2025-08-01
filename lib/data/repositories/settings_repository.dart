import 'package:finance_tracker/data/datasources/settings_local_datasource.dart';
import 'package:finance_tracker/data/models/settings_model.dart';

class SettingsRepository {
  final SettingsLocalDatasource _localDatasource = SettingsLocalDatasource();

  SettingsModel getSettings() {
    return _localDatasource.getSettings();
  }

  Future<void> updateSettings(SettingsModel model) {
    return _localDatasource.updateSettings(model);
  }

  Future<void> resetSettings() {
    return _localDatasource.resetSettings();
  }
}
