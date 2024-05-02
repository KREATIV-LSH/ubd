import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restart_app/restart_app.dart';

import 'dart:html' as html;
import 'package:flutter/foundation.dart';

class SettingsService {
  Future<ThemeMode> themeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString('themeMode') ?? 'system';
    return ThemeMode.values.firstWhere((e) => e.toString() == themeModeString,
        orElse: () => ThemeMode.system);
  }

  Future<void> updateThemeMode(ThemeMode theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', theme.toString());
  }

  Future<String> language() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('language') ?? 'de';
  }

  Future<void> updateLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
    if (kIsWeb) {
      html.window.location.reload();
    } else {
      Restart.restartApp();
    }
  }
}
