import 'dart:ui';

import 'package:flutter/material.dart';

class SettingsService {
  Future<ThemeMode> themeMode() async => ThemeMode.system;

  Future<void> updateThemeMode(ThemeMode theme) async {
  }

  Future<String> language() {
    if(window.locale.toLanguageTag().startsWith('de')) {
      return Future.value('de');
    } else {
      return Future.value('en');
    }
  }

  Future<void> updateLanguage(String language) async {
  }
}
