import 'package:hive/hive.dart';
import 'package:finance_tracker/data/models/settings_model.dart';

class SettingsLocalDatasource {
  final _settingsBox = Hive.box<SettingsModel>('settings');

  SettingsModel getSettings() {
    print("[DEBUG] Getting settings");
    return _settingsBox.isNotEmpty
        ? _settingsBox.values.first
        : SettingsModel(isDarkMode: false, currency: 'USD');
  }

  Future<void> updateSettings(SettingsModel settings) async {
    print("[DEBUG] Updating settings: ${settings.currency}, Dark: ${settings.isDarkMode}");
    if (_settingsBox.isNotEmpty) {
      await _settingsBox.putAt(0, settings);
    } else {
      await _settingsBox.add(settings);
    }
  }

  Future<void> resetSettings() async {
    print("[DEBUG] Resetting settings box");
    await _settingsBox.clear();
  }
}
