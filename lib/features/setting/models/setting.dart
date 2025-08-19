class Setting {
  final APP_THEME appTheme;
  final APP_LANGUAGE appLanguage;
  final int monthlyLimit;

  Setting({
    required this.appTheme,
    required this.appLanguage,
    required this.monthlyLimit,
  });
}

class SettingCode {
  static const String APP_THEME = "app_theme";
  static const String APP_LANGUAGE = "app_language";
  static const String MONTHLY_LIMIT = "monthly_limit";
}

class APP_THEME {
  static const String LIGHT = "Light";
  static const String DARK = "Dark";
}

class APP_LANGUAGE {
  static const String EN = "en";
  static const String ID = "id";
}
