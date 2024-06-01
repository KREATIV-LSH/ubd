import "package:flutter/material.dart";

import "settings_service.dart";

class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService) {
    loadSettings();
  }

  final SettingsService _settingsService;

  late ThemeMode _themeMode;
  late String _language; // Mark _language as late

  ThemeMode get themeMode => _themeMode;
  String get language => _language;

  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();
    _language = await _settingsService.language();
    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    if (newThemeMode == _themeMode) return;

    _themeMode = newThemeMode;

    notifyListeners();

    await _settingsService.updateThemeMode(newThemeMode);
  }

  Future<void> updateLanguage(String newLanguage) async {
    if (newLanguage == _language) return;
    _language = newLanguage;
    notifyListeners();
    await _settingsService.updateLanguage(newLanguage);
  }
}
