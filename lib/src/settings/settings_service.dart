import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:restart_app/restart_app.dart";
import "package:flutter/foundation.dart";
import "package:universal_html/html.dart";


class SettingsService {
  Future<ThemeMode> themeMode() async {
    WidgetsFlutterBinding.ensureInitialized();
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString("themeMode") ?? "system";
    return ThemeMode.values.firstWhere((e) => e.toString() == themeModeString,
        orElse: () => ThemeMode.system);
  }

  Future<void> updateThemeMode(ThemeMode theme) async {
    WidgetsFlutterBinding.ensureInitialized();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("themeMode", theme.toString());
  }

  Future<String> language() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("language") ?? "de";
  }

  Future<void> updateLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", language);
    reloadApp();
  }

  void reloadApp() {
    if (kIsWeb) {
      window.location.reload();
    } else {
      Restart.restartApp();
    }
  }
}
