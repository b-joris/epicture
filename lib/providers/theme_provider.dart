import 'package:epicture/main.dart';
import 'package:flutter/foundation.dart';

class ThemePreferenceProvider with ChangeNotifier {
  static const THEME_STATUS = 'is_dark_theme';
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    sharedPreferences.setBool(THEME_STATUS, value);
    notifyListeners();
  }
}
